// ignore_for_file: prefer_const_constructors

import 'package:project_repository/project_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Project', () {
    test('can be instantiated', () {
      final project = Project(
        name: '',
        path: '',
        entries: const [],
      );
      expect(project, isNotNull);
    });

    test('supports equality', () {
      final project = Project(
        name: '',
        path: '',
        entries: const [],
      );
      expect(
        project,
        equals(
          Project(
            name: '',
            path: '',
            entries: const [],
          ),
        ),
      );

      expect(
        project,
        isNot(
          equals(
            Project(
              name: '1',
              path: '',
              entries: const [],
            ),
          ),
        ),
      );

      expect(
        project,
        isNot(
          equals(
            Project(
              name: '',
              path: '1',
              entries: const [],
            ),
          ),
        ),
      );

      expect(
        project,
        isNot(
          equals(
            Project(
              name: '',
              path: '',
              entries: const [ProjectEntry(name: '1', path: '', isFile: false)],
            ),
          ),
        ),
      );
    });
  });

  group('ProjectEntry', () {
    test('can be instantiated', () {
      final projectEntry = ProjectEntry(
        name: '',
        path: '',
        isFile: false,
      );
      expect(projectEntry, isNotNull);
    });

    test('supports equality', () {
      final projectEntry = ProjectEntry(
        name: '',
        path: '',
        isFile: false,
      );
      expect(
        projectEntry,
        equals(
          ProjectEntry(
            name: '',
            path: '',
            isFile: false,
          ),
        ),
      );

      expect(
        projectEntry,
        isNot(
          equals(
            ProjectEntry(
              name: '1',
              path: '',
              isFile: false,
            ),
          ),
        ),
      );

      expect(
        projectEntry,
        isNot(
          equals(
            ProjectEntry(
              name: '',
              path: '1',
              isFile: false,
            ),
          ),
        ),
      );

      expect(
        projectEntry,
        isNot(
          equals(
            ProjectEntry(
              name: '',
              path: '1',
              isFile: true,
            ),
          ),
        ),
      );
    });
  });
}
