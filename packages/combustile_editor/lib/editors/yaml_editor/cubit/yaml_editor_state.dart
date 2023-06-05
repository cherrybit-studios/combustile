part of 'yaml_editor_cubit.dart';

enum EditorStatus {
  loading,
  loaded,
  failure,
}

enum EditorSavingStatus {
  saving,
  saved,
  failure,
}

class YamlEditorState extends Equatable {
  const YamlEditorState({
    required this.status,
    required this.content,
    required this.savingStatus,
    this.parseErrors = const [],
  });

  final EditorStatus status;
  final EditorSavingStatus savingStatus;
  final String content;
  final List<String> parseErrors;

  YamlEditorState copyWith({
    EditorStatus? status,
    EditorSavingStatus? savingStatus,
    String? content,
    List<String>? parseErrors,
  }) {
    return YamlEditorState(
      status: status ?? this.status,
      savingStatus: savingStatus ?? this.savingStatus,
      content: content ?? this.content,
      parseErrors: parseErrors ?? this.parseErrors,
    );
  }

  @override
  List<Object?> get props => [
        status,
        content,
        savingStatus,
        parseErrors,
      ];
}
