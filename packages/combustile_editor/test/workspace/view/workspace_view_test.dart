import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockWorkspaceCubit extends MockCubit<WorkspaceState>
    implements WorkspaceCubit {}

void main() {
  group('WorkspaceView', () {
    late WorkspaceCubit cubit;

    setUp(() {
      cubit = _MockWorkspaceCubit();
      whenListen(
        cubit,
        Stream.value(const WorkspaceState.initial()),
        initialState: const WorkspaceState.initial(),
      );
    });

    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpSubject(cubit);
      expect(find.text('Combustile'), findsOneWidget);
    });

    testWidgets('can resize the project tree', (tester) async {
      await tester.pumpSubject(cubit);

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
  Future<void> pumpSubject(WorkspaceCubit cubit) async {
    await pumpApp(
      BlocProvider<WorkspaceCubit>.value(
        value: cubit,
        child: const WorkspaceView(),
      ),
    );
  }
}
