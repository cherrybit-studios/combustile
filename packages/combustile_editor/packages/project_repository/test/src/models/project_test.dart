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

    group('copyWith', () {
      test('returns a copy of the project', () {
        final project = Project(
          name: '',
          path: '',
          entries: const [],
        );
        final copy = project.copyWith();
        expect(project, equals(copy));
      });

      test('can update the name', () {
        final project = Project(
          name: '',
          path: '',
          entries: const [],
        );
        final copy = project.copyWith(name: '1');
        expect(
          copy,
          equals(
            Project(
              name: '1',
              path: '',
              entries: const [],
            ),
          ),
        );
      });

      test('can update the path', () {
        final project = Project(
          name: '',
          path: '',
          entries: const [],
        );
        final copy = project.copyWith(path: '1');
        expect(
          copy,
          equals(
            Project(
              name: '',
              path: '1',
              entries: const [],
            ),
          ),
        );
      });

      test('can update the entries', () {
        final project = Project(
          name: '',
          path: '',
          entries: const [],
        );
        final copy = project.copyWith(
          entries: const [
            ProjectEntry(name: '1', path: '', isFile: false),
          ],
        );
        expect(
          copy,
          equals(
            Project(
              name: '',
              path: '',
              entries: const [
                ProjectEntry(name: '1', path: '', isFile: false),
              ],
            ),
          ),
        );
      });
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
