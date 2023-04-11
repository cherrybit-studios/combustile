import 'package:combustile_editor/editors/editors.dart';
import 'package:combustile_editor/l10n/l10n.dart';
import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class Editors extends StatelessWidget {
  const Editors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final filesManager = context.read<FileManager>();
    final workspaceCubit = context.watch<WorkspaceCubit>();
    final state = workspaceCubit.state;

    final tabs = state.tabs.map((filePath) {
      final name = filesManager.fileName(filePath);

      if (filesManager.isImage(filePath)) {
        return NesTabItem(
          label: name,
          child: ImageView(image: filePath),
        );
      } else {
        return NesTabItem(
          label: name,
          child: Center(child: Text(l10n.unknownFileType)),
        );
      }
    }).toList();

    return NesContainer(
      width: double.infinity,
      height: double.infinity,
      child: tabs.isEmpty
          ? const SizedBox.shrink()
          : NesTabView(
              tabs: tabs,
              onTabClosed: workspaceCubit.closeFileTab,
            ),
    );
  }
}
