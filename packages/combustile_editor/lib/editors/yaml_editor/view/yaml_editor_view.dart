import 'package:code_text_field/code_text_field.dart';
import 'package:combustile_editor/editors/editors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/yaml.dart';
import 'package:nes_ui/nes_ui.dart';

class YamlEditorView extends StatefulWidget {
  const YamlEditorView({super.key});

  @override
  State<YamlEditorView> createState() => _YamlEditorViewState();
}

class _YamlEditorViewState extends State<YamlEditorView> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();

    _codeController = CodeController(
      language: yaml,
      text: context.read<YamlEditorCubit>().state.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YamlEditorCubit, YamlEditorState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status == EditorStatus.loaded;
      },
      listener: (context, state) {
        _codeController.text = state.content;
      },
      child: NesSingleChildScrollView(
        child: CodeTheme(
          data: const CodeThemeData(styles: monokaiSublimeTheme),
          child: CodeField(
            controller: _codeController,
          ),
        ),
      ),
    );
  }
}
