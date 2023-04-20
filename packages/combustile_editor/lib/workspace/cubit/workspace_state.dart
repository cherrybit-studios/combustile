part of 'workspace_cubit.dart';

class WorkspaceState extends Equatable {
  const WorkspaceState({
    required this.tabs,
  });

  const WorkspaceState.initial() : tabs = const <String>[];

  final List<String> tabs;

  WorkspaceState copyWith({
    List<String>? tabs,
  }) {
    return WorkspaceState(
      tabs: tabs ?? this.tabs,
    );
  }

  @override
  List<Object> get props => [tabs];
}
