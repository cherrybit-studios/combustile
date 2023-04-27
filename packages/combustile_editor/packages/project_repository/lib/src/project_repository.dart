import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:project_repository/project_repository.dart';

/// {@template file_outside_project_exception}
/// Throws when an attempt to create a file outside of the project is made.
/// {@endtemplate}
class FileOutsideProjectException implements Exception {
  /// {@macro file_outside_project_exception}
  FileOutsideProjectException(this.filePath, this.projectPath, this.stackTrace);

  /// The path of the file that was attempted to be created.
  final String filePath;

  /// The path of the project.
  final String projectPath;

  /// The stack trace.
  final StackTrace stackTrace;

  @override
  String toString() =>
      'FileOutsideProjectException: $filePath is not inside $projectPath';
}

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

/// Function signature for creating a new file.
typedef NewFile = File Function(String path);

/// {@template project_repository}
/// Repository that allows to manipulate and read project files.
///
/// Throws a [ProjectLoadFailure] if a project fails to load.
/// {@endtemplate}
class ProjectRepository {
  /// {@macro project_repository}
  const ProjectRepository({
    NewFile newFile = File.new,
  }) : _newFile = newFile;

  final NewFile _newFile;

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

  /// Creates a new file in the given [project].
  ///
  /// Throws a [FileOutsideProjectException] if the file is not inside the
  /// project.
  Future<ProjectEntry?> createFile(Directory project, String filePath) async {
    final file = _newFile(filePath);

    await file.create();

    if (!file.path.startsWith(project.path)) {
      throw FileOutsideProjectException(
        file.path,
        project.path,
        StackTrace.current,
      );
    }

    return ProjectEntry(
      path: file.path,
      name: path.basename(file.path),
      isFile: true,
    );
  }

  /// Reads a file from the given [filePath].
  Future<String> readFile(String filePath) async {
    final file = _newFile(filePath);

    return file.readAsString();
  }

  /// Writes a file to the given [filePath].
  Future<void> writeFile(String filePath, String content) async {
    final file = _newFile(filePath);

    await file.writeAsString(content);
  }
}
