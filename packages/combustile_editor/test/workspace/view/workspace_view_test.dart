import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:combustile_editor/project/project.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockWorkspaceCubit extends MockCubit<WorkspaceState>
    implements WorkspaceCubit {}

class _MockProjectCubit extends MockCubit<ProjectState>
    implements ProjectCubit {}

class _MockFileManager extends Mock implements FileManager {}

void main() {
  group('WorkspaceView', () {
    late WorkspaceCubit cubit;
    late ProjectCubit projectCubit;
    late FileManager fileManager;

    setUp(() {
      cubit = _MockWorkspaceCubit();
      whenListen(
        cubit,
        Stream.value(const WorkspaceState.initial()),
        initialState: const WorkspaceState.initial(),
      );

      projectCubit = _MockProjectCubit();
      whenListen(
        projectCubit,
        Stream.value(const ProjectStateInitial()),
        initialState: const ProjectStateInitial(),
      );

      fileManager = _MockFileManager();
    });

    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpSubject(
        cubit: cubit,
        projectCubit: projectCubit,
        fileManager: fileManager,
      );
      expect(find.text('Combustile'), findsOneWidget);
    });
  });
}

extension WorkspaceViewTest on WidgetTester {
  Future<void> pumpSubject({
    required WorkspaceCubit cubit,
    required ProjectCubit projectCubit,
    required FileManager fileManager,
  }) async {
    await pumpApp(
      RepositoryProvider<FileManager>.value(
        value: fileManager,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<WorkspaceCubit>.value(value: cubit),
            BlocProvider<ProjectCubit>.value(value: projectCubit),
          ],
          child: const WorkspaceView(),
        ),
      ),
    );
  }
}
