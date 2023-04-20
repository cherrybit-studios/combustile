import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  WorkspaceCubit() : super(const WorkspaceState.initial());

  void openFileTab(String path) {
    if (!state.tabs.contains(path)) {
      emit(state.copyWith(tabs: [...state.tabs, path]));
    }
  }

  void closeFileTab(int i) {
    if (i < state.tabs.length) {
      final newTabs = [...state.tabs]..removeAt(i);
      emit(state.copyWith(tabs: newTabs));
    }
  }
}
