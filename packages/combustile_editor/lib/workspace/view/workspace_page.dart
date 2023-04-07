import 'package:combustile_editor/project/project.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_repository/project_repository.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorkspaceCubit>(
          create: (_) => WorkspaceCubit(),
        ),
        BlocProvider<ProjectCubit>(
          create: (context) {
            final repository = context.read<ProjectRepository>();
            return ProjectCubit(projectRepository: repository);
          },
        )
      ],
      child: const WorkspaceView(),
    );
  }
}
