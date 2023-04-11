import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

import '../../helpers/pump_app.dart';

class _MockProjectRepository extends Mock implements ProjectRepository {}

class _MockFileManager extends Mock implements FileManager {}

void main() {
  group('WorkspacePage', () {
    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ProjectRepository>(
              create: (_) => _MockProjectRepository(),
            ),
            RepositoryProvider<FileManager>(
              create: (_) => _MockFileManager(),
            ),
          ],
          child: const WorkspacePage(),
        ),
      );
      expect(find.byType(WorkspaceView), findsOneWidget);
    });
  });
}
