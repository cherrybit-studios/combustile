// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';

import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFile extends Mock implements File {}

void main() {
  group('FileManager', () {
    test('can be instantiated', () {
      final fileManager = FileManager();
      expect(fileManager, isNotNull);
    });

    test('reads the bytes of a file', () async {
      final mockFile = _MockFile();
      final fileManager = FileManager(createFile: (_) => mockFile);

      when(mockFile.readAsBytes)
          .thenAnswer((_) async => Uint8List.fromList([1, 2, 3]));

      final bytes = await fileManager.loadFileBytes('');
      expect(bytes, Uint8List.fromList([1, 2, 3]));
    });

    test('returns the correct filename', () {
      final fileManager = FileManager();
      expect(fileManager.fileName(''), '');
      expect(fileManager.fileName('a'), 'a');
      expect(fileManager.fileName('a/b'), 'b');
      expect(fileManager.fileName('a/b/c'), 'c');
      expect(fileManager.fileName('a/b/c.png'), 'c.png');
    });

    test('isImage returns correctly', () {
      final fileManager = FileManager();
      expect(fileManager.isImage(''), isFalse);
      expect(fileManager.isImage('a'), isFalse);
      expect(fileManager.isImage('a/b'), isFalse);
      expect(fileManager.isImage('a/b/c'), isFalse);
      expect(fileManager.isImage('a/b/c.png'), isTrue);
      expect(fileManager.isImage('a/b/c.jpg'), isTrue);
      expect(fileManager.isImage('a/b/c.jpeg'), isTrue);
    });
  });
}
