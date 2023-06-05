import 'package:combustile_editor/editors/yaml_editor/yaml_editor.dart';
import 'package:combustile_editor/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<YamlEditorCubit>().state;
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
        children: [
          const Divider(),
          Text(l10n.logs),
          const SizedBox(height: 8),
          Expanded(
            child: NesSingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.parseErrors.map((error) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
