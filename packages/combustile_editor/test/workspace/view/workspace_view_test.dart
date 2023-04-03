import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('WorkspaceView', () {
    testWidgets('renders WorkspaceView', (tester) async {
      await tester.pumpApp(const WorkspaceView());
      expect(find.text('Combustile'), findsOneWidget);
    });
  });
}
