import 'package:combustile_editor/l10n/l10n.dart';
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
      ],
      child: MaterialApp(
        theme: flutterNesTheme(),
        darkTheme: flutterNesTheme(brightness: Brightness.dark),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const WorkspacePage(),
      ),
    );
  }
}
