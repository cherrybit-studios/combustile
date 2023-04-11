import 'package:combustile_editor/l10n/l10n.dart';
import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:project_repository/project_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const ProjectRepository()),
        RepositoryProvider(create: (_) => const FileManager()),
      ],
      child: MaterialApp(
        theme: flutterNesTheme().copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: flutterNesTheme(brightness: Brightness.dark).copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const WorkspacePage(),
      ),
    );
  }
}
