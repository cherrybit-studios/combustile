import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkspaceCubit>(
      create: (_) => WorkspaceCubit(),
      child: const WorkspaceView(),
     );
  }
}
