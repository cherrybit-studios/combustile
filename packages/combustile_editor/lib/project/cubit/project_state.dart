part of 'project_cubit.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();
}

class ProjectStateInitial extends ProjectState {
  const ProjectStateInitial();

  @override
  List<Object> get props => [];
}

enum ProjectOperationError {
  fileOutsideProject,
}

class ProjectStateLoaded extends ProjectState {
  const ProjectStateLoaded({
    required this.project,
    this.errors = const [],
  });

  final Project project;
  final List<ProjectOperationError> errors;

  ProjectStateLoaded copyWith({
    Project? project,
    List<ProjectOperationError>? errors,
  }) {
    return ProjectStateLoaded(
      project: project ?? this.project,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object> get props => [project, errors];
}
