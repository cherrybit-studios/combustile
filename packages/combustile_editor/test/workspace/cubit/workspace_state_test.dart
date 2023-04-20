// ignore_for_file: prefer_const_constructors

import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkspaceState', () {
    test('can be instantied', () {
      final state = WorkspaceState(tabs: const []);
      expect(state, isNotNull);
    });

    test('initial state', () {
      final state = WorkspaceState.initial();
      expect(state.tabs, equals([]));
    });

    test('supports value comparison', () {
      final state = WorkspaceState(tabs: const []);
      expect(state, equals(state));
      expect(
        state,
        isNot(
          equals(
            WorkspaceState(tabs: const ['']),
          ),
        ),
      );
    });

    test('copyWith returns a new instance with the new value', () {
      final state = WorkspaceState(tabs: const []);
      final exactCopy = state.copyWith();

      expect(exactCopy, equals(state));

      final copy = state.copyWith(tabs: ['A']);
      expect(copy, isNot(equals(state)));
      expect(copy.tabs, equals(const ['A']));
    });
  });
}
