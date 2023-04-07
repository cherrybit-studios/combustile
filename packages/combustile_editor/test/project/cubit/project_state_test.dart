// ignore_for_file: prefer_const_constructors

import 'package:combustile_editor/project/cubit/project_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_repository/project_repository.dart';

void main() {
  group('ProjectState', () {
    group('ProjectStateInitial', () {
      test('can be instantiated', () {
        expect(ProjectStateInitial(), isNotNull);
      });

      test('supports value comparisons', () {
        expect(ProjectStateInitial(), equals(ProjectStateInitial()));
      });
    });

    group('ProjectStateLoaded', () {
      test('can be instantiated', () {
        expect(
          ProjectStateLoaded(
            project: Project(
              entries: const [],
              name: '',
              path: '',
            ),
          ),
          isNotNull,
        );
      });

      test('supports value comparisons', () {
        expect(
          ProjectStateLoaded(
            project: Project(
              entries: const [],
              name: '',
              path: '',
            ),
          ),
          equals(
            ProjectStateLoaded(
              project: Project(
                entries: const [],
                name: '',
                path: '',
              ),
            ),
          ),
        );

        expect(
          ProjectStateLoaded(
            project: Project(
              entries: const [],
              name: '',
              path: '',
            ),
          ),
          isNot(
            equals(
              ProjectStateLoaded(
                project: Project(
                  entries: const [],
                  name: 'a',
                  path: '',
                ),
              ),
            ),
          ),
        );
      });
    });
  });
}
