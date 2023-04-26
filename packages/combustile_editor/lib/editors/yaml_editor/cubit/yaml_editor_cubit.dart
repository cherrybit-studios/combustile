import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_repository/project_repository.dart';

part 'yaml_editor_state.dart';

class YamlEditorCubit extends Cubit<YamlEditorState> {
  YamlEditorCubit({
    required ProjectRepository repository,
    required this.filePath,
  })  : _repository = repository,
        super(
          const YamlEditorState(
            status: EditorStatus.loading,
            content: '',
          ),
        );

  final ProjectRepository _repository;
  final String filePath;

  Future<void> load() async {
    emit(state.copyWith(status: EditorStatus.loading));

    try {
      final content = await _repository.readFile(filePath);
      emit(state.copyWith(status: EditorStatus.loaded, content: content));
    } catch (e, s) {
      addError(e, s);
      emit(state.copyWith(status: EditorStatus.failure));
    }
  }
}
