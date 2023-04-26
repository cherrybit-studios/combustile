import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/editors/editors.dart';
import 'package:combustile_editor/platform_tools/platform_tools.dart';
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

class _MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  group('Workspace Editors', () {
    late FileManager fileManager;
    late WorkspaceCubit workspaceCubit;
    late ProjectRepository projectRepository;

    setUp(() {
      fileManager = _MockFileManager();
      workspaceCubit = _MockWorkspaceCubit();
      projectRepository = _MockProjectRepository();

      const state = WorkspaceState(
        tabs: ['test'],
      );

      whenListen(
        workspaceCubit,
        Stream.value(state),
        initialState: state,
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
          ],
          child: const Scaffold(body: Editors()),
        ),
      ),
    );
  }
}
