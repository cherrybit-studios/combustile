import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('WorkspacePage', () {
    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpApp(const WorkspacePage());
      expect(find.byType(WorkspaceView), findsOneWidget);
    });
  });
}
