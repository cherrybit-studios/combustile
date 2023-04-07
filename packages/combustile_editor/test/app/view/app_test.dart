import 'package:combustile_editor/app/app.dart';
import 'package:combustile_editor/workspace/workspace.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders WorkspacePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(WorkspacePage), findsOneWidget);
    });
  });
}
