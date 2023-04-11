import 'package:combustile_editor/project/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class ProjectTree extends StatelessWidget {
  const ProjectTree({
    super.key,
    required this.width,
    required this.onOpenFile,
  });

  final double width;
  final void Function(String) onOpenFile;

  static const openKey = Key('project_tree_open_key');

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.watch<ProjectCubit>();
    final state = projectCubit.state;

    return NesContainer(
      width: width,
      height: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              NesPressable(
                onPress: () {
                  context.read<ProjectCubit>().loadProject();
                },
                child: NesIcon(
                  key: openKey,
                  iconData: NesIcons.instance.openFolder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Expanded(
            child: (state is ProjectStateLoaded)
                ? NesSingleChildScrollView(
                    clipContent: true,
                    child: NesFileExplorer(
                      onOpenFile: (file) {
                        onOpenFile(file.path);
                      },
                      entries: [
                        for (final entry in state.project.entries)
                          if (entry.isFile)
                            NesFile(entry.path)
                          else
                            NesFolder(entry.path)
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
