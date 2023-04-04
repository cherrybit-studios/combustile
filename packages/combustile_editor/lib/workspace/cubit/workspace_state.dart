part of 'workspace_cubit.dart';

class WorkspaceState extends Equatable {
  const WorkspaceState({
    required this.projectTreeSize,
  });

  const WorkspaceState.initial() : projectTreeSize = 200;

  final double projectTreeSize;

  WorkspaceState copyWith({
    double? projectTreeSize,
  }) {
    return WorkspaceState(
      projectTreeSize: projectTreeSize ?? this.projectTreeSize,
    );
  }

  @override
  List<Object> get props => [projectTreeSize];
}
