import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkspaceCubit', () {
    test('can be instantiated', () {
      final cubit = WorkspaceCubit();
      expect(cubit, isNotNull);
    });

    test('has the right initial state', () {
      final cubit = WorkspaceCubit();
      expect(cubit.state, equals(const WorkspaceState.initial()));
    });

    blocTest<WorkspaceCubit, WorkspaceState>(
      'resizeProjectTreeSize emits the correct state',
      build: WorkspaceCubit.new,
      act: (cubit) => cubit.resizeProjectTreeSize(201),
      expect: () => [const WorkspaceState(projectTreeSize: 201)],
    );
  });
}
