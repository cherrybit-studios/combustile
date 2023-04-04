// ignore_for_file: prefer_const_constructors

import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkspaceState', () {
    test('can be instantied', () {
      final state = WorkspaceState(projectTreeSize: 200);
      expect(state.projectTreeSize, equals(200));
    });

    test('initial state', () {
      final state = WorkspaceState.initial();
      expect(state.projectTreeSize, equals(200));
    });

    test('supports value comparison', () {
      final state = WorkspaceState(projectTreeSize: 200);
      expect(state, state);
      expect(
        state,
        isNot(
          equals(
            WorkspaceState(projectTreeSize: 201),
          ),
        ),
      );
    });

    test('copyWith returns a new instance with the new value', () {
      final state = WorkspaceState(projectTreeSize: 200);
      final exactCopy = state.copyWith();

      expect(exactCopy, equals(state));

      final copy = state.copyWith(projectTreeSize: 201);
      expect(copy, isNot(equals(state)));
      expect(copy.projectTreeSize, equals(201));
    });
  });
}
