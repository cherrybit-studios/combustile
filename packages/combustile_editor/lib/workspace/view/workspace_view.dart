import 'package:combustile_editor/l10n/l10n.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  static const resizeProjectTreeKey = Key('resizeProjectTreeKey');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final workspaceCubit = context.watch<WorkspaceCubit>();
    final state = workspaceCubit.state;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: Center(child: Text(l10n.combustile)),
            ),
            Expanded(
              child: Row(
                children: [
                  ProjectTree(width: state.projectTreeSize),
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      workspaceCubit.resizeProjectTreeSize(
                        state.projectTreeSize + details.delta.dx,
                      );
                    },
                    child: SizedBox(
                      width: 24,
                      child: Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.resizeColumn,
                          child: NesIcon(
                            key: resizeProjectTreeKey,
                            size: const Size.square(24),
                            iconData: NesIcons.instance.threeVerticalDots,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Editors(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
