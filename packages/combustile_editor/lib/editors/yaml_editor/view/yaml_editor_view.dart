import 'dart:async';

import 'package:code_text_field/code_text_field.dart';
import 'package:combustile_editor/editors/editors.dart';
import 'package:combustile_editor/l10n/l10n.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/yaml.dart';
import 'package:nes_ui/nes_ui.dart';

class YamlEditorView extends StatefulWidget {
  const YamlEditorView({
    super.key,
    required this.projectPath,
  });

  final String projectPath;

  static const saveIconKey = Key('_save_icon_key');

  @override
  State<YamlEditorView> createState() => _YamlEditorViewState();
}

class _YamlEditorViewState extends State<YamlEditorView> {
  late CodeController _codeController;

  bool _isDirty = false;
  final _windowSize = Vector2(200, 100);
  final _windowPosition = Vector2.zero();
  late final _previewGame = PreviewGame(widget.projectPath);

  @override
  void initState() {
    super.initState();
    final text = context.read<YamlEditorCubit>().state.content;

    _codeController = CodeController(
      language: yaml,
      text: text,
    )..addListener(() {
        if (!_isDirty) {
          setState(() {
            _isDirty = _codeController.text !=
                context.read<YamlEditorCubit>().state.content;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        BlocBuilder<YamlEditorCubit, YamlEditorState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  NesIconButton(
                    key: YamlEditorView.saveIconKey,
                    icon: NesIcons.instance.saveFile,
                    onPress: (state.savingStatus == EditorSavingStatus.saving ||
                            !_isDirty)
                        ? null
                        : () async {
                            await context.read<YamlEditorCubit>().save(
                                  _codeController.text,
                                );
                            unawaited(
                              _previewGame.reloadYaml(
                                _codeController.text,
                              ),
                            );
                            setState(() {
                              _isDirty = false;
                            });
                          },
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(),
        Expanded(
          child: BlocListener<YamlEditorCubit, YamlEditorState>(
            listenWhen: (previous, current) {
              return previous.status != current.status &&
                  current.status == EditorStatus.loaded;
            },
            listener: (context, state) {
              _previewGame.reloadYaml(state.content);
              _codeController.text = state.content;
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: NesSingleChildScrollView(
                    child: CodeTheme(
                      data: const CodeThemeData(styles: monokaiSublimeTheme),
                      child: CodeField(
                        controller: _codeController,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: _windowPosition.y,
                  left: _windowPosition.x,
                  child: NesDropshadow(
                    child: NesWindow(
                      title: l10n.preview,
                      width: _windowSize.x,
                      height: _windowSize.y,
                      onResize: (size) {
                        setState(() {
                          _windowSize
                            ..x += size.dx
                            ..y += size.dy;
                        });
                      },
                      onMove: (delta) {
                        setState(() {
                          _windowPosition
                            ..x += delta.dx
                            ..y += delta.dy;
                        });
                      },
                      child: Expanded(
                        child: ClipRect(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: GameWidget(game: _previewGame),
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: NesIconButton(
                                  icon: NesIcons.instance.zoomIn,
                                  onPress: () {
                                    _previewGame.zoomIn();
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                left: 4,
                                child: NesIconButton(
                                  icon: NesIcons.instance.zoomOut,
                                  onPress: () {
                                    _previewGame.zoomOut();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
