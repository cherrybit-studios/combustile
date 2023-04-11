part of 'workspace_cubit.dart';

class WorkspaceState extends Equatable {
  const WorkspaceState({
    required this.projectTreeSize,
    required this.tabs,
  });

  const WorkspaceState.initial()
      : projectTreeSize = 200,
        tabs = const <String>[];

  final double projectTreeSize;
  final List<String> tabs;

  WorkspaceState copyWith({
    double? projectTreeSize,
    List<String>? tabs,
  }) {
    return WorkspaceState(
      projectTreeSize: projectTreeSize ?? this.projectTreeSize,
      tabs: tabs ?? this.tabs,
    );
  }

  @override
  List<Object> get props => [projectTreeSize, tabs];
}
