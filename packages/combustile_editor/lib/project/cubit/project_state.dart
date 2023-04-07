part of 'project_cubit.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();
}

class ProjectStateInitial extends ProjectState {
  const ProjectStateInitial();

  @override
  List<Object> get props => [];
}

class ProjectStateLoaded extends ProjectState {
  const ProjectStateLoaded({
    required this.project,
  });

  final Project project;

  @override
  List<Object> get props => [project];
}
