// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/project/cubit/project_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

class _MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  group('ProjectCubit', () {
    late ProjectRepository projectRepository;

    setUpAll(() {
      registerFallbackValue(Directory(''));
    });

    setUp(() {
      projectRepository = _MockProjectRepository();
    });

    test('can be instantiated', () {
      expect(
        ProjectCubit(projectRepository: _MockProjectRepository()),
        isNotNull,
      );
    });

    test('has the correct initial state', () {
      expect(
        ProjectCubit(projectRepository: _MockProjectRepository()).state,
        equals(
          ProjectStateInitial(),
        ),
      );
    });

    blocTest<ProjectCubit, ProjectState>(
      'emits ProjectStateLoaded when loadProject is called',
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        loadPath: () async => 'a',
      ),
      setUp: () {
        when(() => projectRepository.loadProject(any())).thenAnswer(
          (_) async => Project(
            entries: const [],
            name: '',
            path: '',
          ),
        );
      },
      act: (cubit) => cubit.loadProject(),
      expect: () => [
        ProjectStateLoaded(
          project: Project(
            entries: const [],
            name: '',
            path: '',
          ),
        ),
      ],
    );

    blocTest<ProjectCubit, ProjectState>(
      "doesn't emits ProjectStateLoaded is null is returned",
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        loadPath: () async => null,
      ),
      act: (cubit) => cubit.loadProject(),
      expect: () => const <ProjectState>[],
    );
  });
}
