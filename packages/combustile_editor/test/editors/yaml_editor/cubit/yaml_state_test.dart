// ignore_for_file: prefer_const_constructors

import 'package:combustile_editor/editors/editors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('YamlEditorState', () {
    test('can be instantiated', () {
      final state = YamlEditorState(
        status: EditorStatus.loading,
        content: 'content',
      );
      expect(state, isNotNull);
    });

    test('supports equality', () {
      final state = YamlEditorState(
        status: EditorStatus.loading,
        content: 'content',
      );
      expect(
        state,
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
          ),
        ),
      );

      expect(
        state,
        isNot(
          equals(
            YamlEditorState(
              status: EditorStatus.loaded,
              content: 'content',
            ),
          ),
        ),
      );

      expect(
        state,
        isNot(
          equals(
            YamlEditorState(
              status: EditorStatus.loading,
              content: 'content 2',
            ),
          ),
        ),
      );
    });

    test('copyWith returns a new instance', () {
      expect(
        YamlEditorState(
          status: EditorStatus.loading,
          content: 'content',
        ).copyWith(),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
          ),
        ),
      );

      expect(
        YamlEditorState(
          status: EditorStatus.loaded,
          content: 'content',
        ).copyWith(status: EditorStatus.loading),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
          ),
        ),
      );

      expect(
        YamlEditorState(
          status: EditorStatus.loading,
          content: 'content',
        ).copyWith(content: 'content 2'),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content 2',
          ),
        ),
      );
    });
  });
}
