import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

import '../../helpers/pump_app.dart';

class _MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  group('WorkspacePage', () {
    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpApp(
        RepositoryProvider<ProjectRepository>(
          create: (_) => _MockProjectRepository(),
          child: const WorkspacePage(),
        ),
      );
      expect(find.byType(WorkspaceView), findsOneWidget);
    });
  });
}
