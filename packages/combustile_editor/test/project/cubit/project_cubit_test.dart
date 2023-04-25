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
      "loadProject doesn't emits ProjectStateLoaded if null is returned",
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        loadPath: () async => null,
      ),
      act: (cubit) => cubit.loadProject(),
      expect: () => const <ProjectState>[],
    );

    blocTest<ProjectCubit, ProjectState>(
      "createFile doesn't emits a new state if null is returned",
      seed: () => ProjectStateLoaded(
        project: Project(
          entries: const [],
          name: '',
          path: '',
        ),
      ),
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        createNewFile: () async => null,
      ),
      act: (cubit) => cubit.createFile(),
      expect: () => const <ProjectState>[],
    );

    blocTest<ProjectCubit, ProjectState>(
      'emits file outside the project if the path is not inside the project',
      setUp: () {
        when(() => projectRepository.createFile(any(), any())).thenThrow(
          FileOutsideProjectException('', '', StackTrace.empty),
        );
      },
      seed: () => ProjectStateLoaded(
        project: Project(
          entries: const [],
          name: '',
          path: '',
        ),
      ),
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        createNewFile: () async => 'asd',
      ),
      act: (cubit) => cubit.createFile(),
      expect: () => const <ProjectState>[
        ProjectStateLoaded(
          project: Project(
            entries: [],
            name: '',
            path: '',
          ),
          errors: [ProjectOperationError.fileOutsideProject],
        ),
      ],
    );

    blocTest<ProjectCubit, ProjectState>(
      "createFile doesn't emits a new state if state is not the correct",
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        createNewFile: () async => null,
      ),
      act: (cubit) => cubit.createFile(),
      expect: () => const <ProjectState>[],
    );

    blocTest<ProjectCubit, ProjectState>(
      "createFile doesn't emits the new project witht the new file",
      setUp: () {
        when(() => projectRepository.createFile(any(), any())).thenAnswer(
          (_) async => ProjectEntry(
            name: 'bla.dart',
            path: '/bla.dart',
            isFile: true,
          ),
        );
        when(() => projectRepository.loadProject(any())).thenAnswer(
          (_) async => Project(
            entries: const [
              ProjectEntry(
                name: 'bla.dart',
                path: '/bla.dart',
                isFile: true,
              ),
            ],
            name: '',
            path: '',
          ),
        );
      },
      seed: () => ProjectStateLoaded(
        project: Project(
          entries: const [],
          name: '',
          path: '',
        ),
      ),
      build: () => ProjectCubit(
        projectRepository: projectRepository,
        createNewFile: () async => '/bla.dart',
      ),
      act: (cubit) => cubit.createFile(),
      expect: () => const <ProjectState>[
        ProjectStateLoaded(
          project: Project(
            entries: [
              ProjectEntry(
                name: 'bla.dart',
                path: '/bla.dart',
                isFile: true,
              ),
            ],
            name: '',
            path: '',
          ),
        )
      ],
    );
  });
}
