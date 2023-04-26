part of 'yaml_editor_cubit.dart';

enum EditorStatus {
  loading,
  loaded,
  failure,
}

class YamlEditorState extends Equatable {
  const YamlEditorState({
    required this.status,
    required this.content,
  });

  final EditorStatus status;
  final String content;

  YamlEditorState copyWith({
    EditorStatus? status,
    String? content,
  }) {
    return YamlEditorState(
      status: status ?? this.status,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [status, content];
}
