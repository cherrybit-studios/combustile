import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workspace_state.dart';

class WorkspaceCubit extends Cubit<WorkspaceState> {
  WorkspaceCubit() : super(const WorkspaceState.initial());

  void resizeProjectTreeSize(double size) {
    if (size > 0) {
      emit(state.copyWith(projectTreeSize: size));
    }
  }
}
