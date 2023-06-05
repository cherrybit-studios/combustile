// ignore_for_file: prefer_const_constructors

import 'package:combustile_editor/editors/editors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('YamlEditorState', () {
    test('can be instantiated', () {
      final state = YamlEditorState(
        status: EditorStatus.loading,
        content: 'content',
        savingStatus: EditorSavingStatus.saved,
      );
      expect(state, isNotNull);
    });

    test('supports equality', () {
      final state = YamlEditorState(
        status: EditorStatus.loading,
        content: 'content',
        savingStatus: EditorSavingStatus.saved,
      );
      expect(
        state,
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
            savingStatus: EditorSavingStatus.saved,
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
              savingStatus: EditorSavingStatus.saved,
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
              savingStatus: EditorSavingStatus.saved,
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
              content: 'content',
              savingStatus: EditorSavingStatus.saving,
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
          savingStatus: EditorSavingStatus.saved,
        ).copyWith(),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
            savingStatus: EditorSavingStatus.saved,
          ),
        ),
      );

      expect(
        YamlEditorState(
          status: EditorStatus.loaded,
          content: 'content',
          savingStatus: EditorSavingStatus.saved,
        ).copyWith(status: EditorStatus.loading),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
            savingStatus: EditorSavingStatus.saved,
          ),
        ),
      );

      expect(
        YamlEditorState(
          status: EditorStatus.loading,
          content: 'content',
          savingStatus: EditorSavingStatus.saved,
        ).copyWith(content: 'content 2'),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content 2',
            savingStatus: EditorSavingStatus.saved,
          ),
        ),
      );

      expect(
        YamlEditorState(
          status: EditorStatus.loading,
          content: 'content',
          savingStatus: EditorSavingStatus.saved,
        ).copyWith(savingStatus: EditorSavingStatus.saving),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
            savingStatus: EditorSavingStatus.saving,
          ),
        ),
      );

      expect(
        YamlEditorState(
          status: EditorStatus.loading,
          content: 'content',
          savingStatus: EditorSavingStatus.saved,
        ).copyWith(parseErrors: ['error']),
        equals(
          YamlEditorState(
            status: EditorStatus.loading,
            content: 'content',
            savingStatus: EditorSavingStatus.saved,
            parseErrors: const ['error'],
          ),
        ),
      );
    });
  });
}
