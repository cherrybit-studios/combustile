import 'package:combustile_editor/l10n/l10n.dart';
import 'package:combustile_editor/project/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';

class ProjectTree extends StatelessWidget {
  const ProjectTree({
    super.key,
    required this.onOpenFile,
  });

  final void Function(String) onOpenFile;

  static const openKey = Key('project_tree_open_key');
  static const newFileKey = Key('project_tree_new_file_key');

  @override
  Widget build(BuildContext context) {
    final projectCubit = context.watch<ProjectCubit>();
    final state = projectCubit.state;

    return BlocListener<ProjectCubit, ProjectState>(
      listenWhen: (previous, current) {
        if (current is ProjectStateLoaded && previous is ProjectStateLoaded) {
          return current.errors != previous.errors;
        }
        return false;
      },
      listener: (context, state) {
        final loadedState = state as ProjectStateLoaded;
        final lastError = loadedState.errors.last;
        switch (lastError) {
          case ProjectOperationError.fileOutsideProject:
            final l10n = context.l10n;
            NesSnackbar.show(
              context,
              text: l10n.fileOutsideProjectError,
              type: NesSnackbarType.error,
            );
            break;
        }
      },
      child: NesContainer(
        height: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                NesPressable(
                  onPress: context.read<ProjectCubit>().loadProject,
                  child: NesIcon(
                    key: openKey,
                    iconData: NesIcons.instance.openFolder,
                  ),
                ),
                const SizedBox(width: 16),
                if (state is ProjectStateLoaded)
                  NesPressable(
                    onPress: context.read<ProjectCubit>().createFile,
                    child: NesIcon(
                      key: newFileKey,
                      iconData: NesIcons.instance.newFile,
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
      ),
    );
  }
}
