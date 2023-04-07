import 'package:bloc_test/bloc_test.dart';
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

void main() {
  group('WorkspaceView', () {
    late WorkspaceCubit cubit;
    late ProjectCubit projectCubit;

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
    });

    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpSubject(cubit: cubit, projectCubit: projectCubit);
      expect(find.text('Combustile'), findsOneWidget);
    });

    testWidgets('can resize the project tree', (tester) async {
      await tester.pumpSubject(cubit: cubit, projectCubit: projectCubit);

      await tester.drag(
        find.byKey(WorkspaceView.resizeProjectTreeKey),
        const Offset(-10, 0),
      );
      await tester.pumpAndSettle();

      verify(() => cubit.resizeProjectTreeSize(190)).called(1);
    });
  });
}

extension WorkspaceViewTest on WidgetTester {
  Future<void> pumpSubject({
    required WorkspaceCubit cubit,
    required ProjectCubit projectCubit,
  }) async {
    await pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<WorkspaceCubit>.value(value: cubit),
          BlocProvider<ProjectCubit>.value(value: projectCubit),
        ],
        child: const WorkspaceView(),
      ),
    );
  }
}
