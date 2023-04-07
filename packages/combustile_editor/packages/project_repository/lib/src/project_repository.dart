import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:project_repository/project_repository.dart';

/// {@template project_load_failure}
/// Throws when a project fails to load.
/// {@endtemplate}
class ProjectLoadFailure implements Exception {
  /// {@macro project_load_failure}
  const ProjectLoadFailure(this.message, this.stackTrace);

  /// The error message.
  final String message;

  /// The stack trace.
  final StackTrace stackTrace;

  @override
  String toString() => 'ProjectLoadFailure: $message';
}

/// {@template project_repository}
/// Repository that allows to manipulate and read project files.
///
/// Throws a [ProjectLoadFailure] if a project fails to load.
/// {@endtemplate}
class ProjectRepository {
  /// {@macro project_repository}
  const ProjectRepository();

  /// Loads a project from the given [path].
  Future<Project> loadProject(Directory project) async {
    try {
      final list = project.list(recursive: true);

      final entries = <ProjectEntry>[];

      await for (final entry in list) {
        entries.add(
          ProjectEntry(
            path: entry.path,
            name: path.basename(entry.path),
            isFile: entry is File,
          ),
        );
      }

      return Project(
        name: path.basename(project.path),
        path: project.path,
        entries: entries,
      );
    } catch (e, s) {
      throw ProjectLoadFailure(e.toString(), s);
    }
  }
}
