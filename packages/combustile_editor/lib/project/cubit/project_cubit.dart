import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_selector/file_selector.dart';
import 'package:project_repository/project_repository.dart';

part 'project_state.dart';

typedef LoadPath = Future<String?> Function();

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit({
    this.loadPath = getDirectoryPath,
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(
          const ProjectStateInitial(),
        );

  final LoadPath loadPath;

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
}
