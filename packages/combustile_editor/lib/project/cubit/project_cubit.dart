import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:project_repository/project_repository.dart';

part 'project_state.dart';

typedef LoadPath = Future<String?> Function();
typedef CreateFile = Future<String?> Function();

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit({
    this.loadPath = getDirectoryPath,
    this.createNewFile = getSavePath,
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(
          const ProjectStateInitial(),
        );

  final LoadPath loadPath;
  final CreateFile createNewFile;

  final ProjectRepository _projectRepository;

  Future<void> loadProject() async {
    final projectPath = await loadPath();
    if (projectPath != null) {
      final project = await _projectRepository.loadProject(
        Directory(projectPath),
      );
      emit(ProjectStateLoaded(project: project));
    }
  }

  Future<void> createFile() async {
    if (state is! ProjectStateLoaded) {
      return;
    }

    final filePath = await createNewFile();
    if (filePath != null) {
      final loadedState = state as ProjectStateLoaded;
      final projectPath = loadedState.project.path;
      final projectDir = Directory(projectPath);

      try {
        await _projectRepository.createFile(
          projectDir,
          filePath,
        );
      } on FileOutsideProjectException catch (_) {
        emit(
          loadedState.copyWith(
            errors: [
              ProjectOperationError.fileOutsideProject,
            ],
          ),
        );
        return;
      }

      // This is just a quick win for now.
      // We should probably just add the new file to the project
      // and emit a new state to avoid unnecessary loading.
      final project = await _projectRepository.loadProject(
        projectDir,
      );
      emit(ProjectStateLoaded(project: project));
    }
  }
}
