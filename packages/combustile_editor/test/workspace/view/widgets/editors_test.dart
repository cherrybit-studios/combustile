import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/editors/editors.dart';
import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:combustile_editor/project/project.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

import '../../../helpers/helpers.dart';

class _MockFileManager extends Mock implements FileManager {}

class _MockWorkspaceCubit extends MockCubit<WorkspaceState>
    implements WorkspaceCubit {}

class _MockProjectCubit extends MockCubit<ProjectState>
    implements ProjectCubit {}

class _MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  group('Workspace Editors', () {
    late FileManager fileManager;
    late WorkspaceCubit workspaceCubit;
    late ProjectCubit projectCubit;
    late ProjectRepository projectRepository;

    setUp(() {
      fileManager = _MockFileManager();
      workspaceCubit = _MockWorkspaceCubit();
      projectCubit = _MockProjectCubit();
      projectRepository = _MockProjectRepository();

      const state = WorkspaceState(
        tabs: ['test'],
      );

      whenListen(
        workspaceCubit,
        Stream.value(state),
        initialState: state,
      );

      const projectState = ProjectStateLoaded(
        project: Project(
          path: 'test',
          name: 'test',
          entries: [],
        ),
      );

      whenListen(
        projectCubit,
        Stream.value(projectState),
        initialState: projectState,
      );

      when(() => fileManager.loadFileBytes(any())).thenAnswer(
        (_) async => Uint8List.fromList([]),
      );
      when(() => fileManager.fileName(any())).thenReturn('test');
      when(() => fileManager.isImage(any())).thenReturn(false);
      when(() => fileManager.isYaml(any())).thenReturn(false);
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpSubject(
        cubit: workspaceCubit,
        projectCubit: projectCubit,
        fileManager: fileManager,
        projectRepository: projectRepository,
      );

      expect(find.byType(Editors), findsOneWidget);
    });

    testWidgets(
      'renders unknown file type when the tab is not known',
      (tester) async {
        await tester.pumpSubject(
          cubit: workspaceCubit,
          projectCubit: projectCubit,
          fileManager: fileManager,
          projectRepository: projectRepository,
        );

        expect(find.text('Unknown File type'), findsOneWidget);
      },
    );

    testWidgets(
      'renders an image view when the file is an image',
      (tester) async {
        when(() => fileManager.fileName(any())).thenReturn('test.png');
        when(() => fileManager.isImage(any())).thenReturn(true);
        await tester.pumpSubject(
          cubit: workspaceCubit,
          projectCubit: projectCubit,
          fileManager: fileManager,
          projectRepository: projectRepository,
        );

        expect(find.byType(ImageView), findsOneWidget);
      },
    );

    testWidgets(
      'renders a yaml editor when the file is a yaml',
      (tester) async {
        when(() => fileManager.fileName(any())).thenReturn('test.yaml');
        when(() => fileManager.isYaml(any())).thenReturn(true);
        await tester.pumpSubject(
          cubit: workspaceCubit,
          projectCubit: projectCubit,
          fileManager: fileManager,
          projectRepository: projectRepository,
        );

        expect(find.byType(YamlEditor), findsOneWidget);
      },
    );
  });
}

extension WorkspaceEditorTest on WidgetTester {
  Future<void> pumpSubject({
    required WorkspaceCubit cubit,
    required ProjectCubit projectCubit,
    required FileManager fileManager,
    required ProjectRepository projectRepository,
  }) async {
    await pumpApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<FileManager>.value(
            value: fileManager,
          ),
          RepositoryProvider<ProjectRepository>.value(
            value: projectRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<WorkspaceCubit>.value(value: cubit),
            BlocProvider<ProjectCubit>.value(value: projectCubit),
          ],
          child: const Scaffold(body: Editors()),
        ),
      ),
    );
  }
}
