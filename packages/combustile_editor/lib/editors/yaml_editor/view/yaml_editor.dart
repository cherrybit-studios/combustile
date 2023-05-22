import 'package:combustile_editor/editors/editors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_repository/project_repository.dart';

class YamlEditor extends StatelessWidget {
  const YamlEditor({
    super.key,
    required this.filePath,
    required this.projectPath,
  });

  final String filePath;
  final String projectPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<YamlEditorCubit>(
      create: (context) {
        final projectRepository = context.read<ProjectRepository>();
        return YamlEditorCubit(
          repository: projectRepository,
          filePath: filePath,
        )..load();
      },
      child: YamlEditorView(projectPath: projectPath),
    );
  }
}
