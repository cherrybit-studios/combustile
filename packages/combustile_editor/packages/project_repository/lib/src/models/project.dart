import 'package:equatable/equatable.dart';

/// {@template project_entry}
/// A model representing a project entry.
/// {@endtemplate}
class ProjectEntry extends Equatable {
  /// {@macro project_entry}
  const ProjectEntry({
    required this.name,
    required this.path,
    required this.isFile,
  });

  /// The name of the entry.
  final String name;

  /// The path to the entry.
  final String path;

  /// Whether the entry is a file.
  final bool isFile;

  @override
  List<Object> get props => [name, path, isFile];
}

/// {@template project}
/// A model representing a project.
/// {@endtemplate}
class Project extends Equatable {
  /// {@macro project}
  const Project({
    required this.path,
    required this.name,
    required this.entries,
  });

  /// The path to the project.
  final String path;

  /// The name of the project.
  final String name;

  /// The entries of the project.
  final List<ProjectEntry> entries;

  /// Creates a copy of the project with the given fields replaced with the new
  /// values.
  Project copyWith({
    String? path,
    String? name,
    List<ProjectEntry>? entries,
  }) {
    return Project(
      path: path ?? this.path,
      name: name ?? this.name,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<Object> get props => [path, name, entries];
}
