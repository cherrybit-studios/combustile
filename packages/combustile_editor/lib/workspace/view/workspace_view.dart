import 'package:combustile_editor/project/project.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  static const resizeProjectTreeKey = Key('resizeProjectTreeKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
              child: Toolbar(),
            ),
            Expanded(
              child: NesSplitPanel(
                initialSizes: const [.2, .8],
                children: [
                  ProjectTree(
                    onOpenFile: context.read<WorkspaceCubit>().openFileTab,
                  ),
                  const Editors(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
