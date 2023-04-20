import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/project/project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

import '../../helpers/helpers.dart';

class _MockProjectCubit extends Mock implements ProjectCubit {}

void main() {
  group('ProjectTree', () {
    late ProjectCubit projectCubit;

    setUp(() {
      projectCubit = _MockProjectCubit();
      when(projectCubit.loadProject).thenAnswer((_) async {});
      whenListen(
        projectCubit,
        Stream.fromIterable(
          [
            const ProjectStateInitial(),
          ],
        ),
        initialState: const ProjectStateInitial(),
      );
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpSubject(projectCubit);
      expect(find.byType(ProjectTree), findsOneWidget);
    });

    testWidgets('can open a project', (tester) async {
      await tester.pumpSubject(projectCubit);

      await tester.tap(find.byKey(ProjectTree.openKey));
      await tester.pump();

      verify(projectCubit.loadProject).called(1);
    });

    testWidgets('can open a file', (tester) async {
      String? selected;
      const state = ProjectStateLoaded(
        project: Project(
          entries: [
            ProjectEntry(
              name: 'my_file.dart',
              path: 'my_file.dart',
              isFile: true,
            ),
            ProjectEntry(
              name: 'src',
              path: 'src',
              isFile: false,
            ),
          ],
          name: 'a',
          path: 'a',
        ),
      );
      whenListen(
        projectCubit,
        Stream.fromIterable([state]),
        initialState: state,
      );
      await tester.pumpSubject(projectCubit, (value) => selected = value);

      await tester.tap(find.text('my_file.dart'));
      await tester.pump();

      expect(selected, equals('my_file.dart'));
    });
  });
}

extension on WidgetTester {
  Future<void> pumpSubject(
    ProjectCubit projectCubit, [
    void Function(String)? onOpenFile,
  ]) async {
    await pumpApp(
      BlocProvider<ProjectCubit>.value(
        value: projectCubit,
        child: ProjectTree(
          onOpenFile: onOpenFile ?? (_) {},
        ),
      ),
    );
  }
}
