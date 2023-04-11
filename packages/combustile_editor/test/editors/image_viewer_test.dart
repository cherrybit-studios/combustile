import 'dart:io';

import 'package:combustile_editor/editors/editors.dart';
import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/pump_app.dart';

class _MockFileManager extends Mock implements FileManager {}

void main() {
  group('Editors - ImageView', () {
    late FileManager fileManager;

    setUp(() {
      final bytes = File('test/assets/square.png').readAsBytesSync();
      fileManager = _MockFileManager();

      when(() => fileManager.loadFileBytes(any())).thenAnswer(
        (_) async => bytes,
      );
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpSubject(
        fileManager: fileManager,
      );
      await tester.pumpAndSettle();

      expect(find.byType(ImageView), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}

extension ImageViewTest on WidgetTester {
  Future<void> pumpSubject({
    required FileManager fileManager,
  }) {
    return pumpApp(
      RepositoryProvider.value(
        value: fileManager,
        child: const ImageView(image: 'assets/square.png'),
      ),
    );
  }
}
