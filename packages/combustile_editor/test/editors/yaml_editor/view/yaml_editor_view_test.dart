import 'package:bloc_test/bloc_test.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:combustile_editor/editors/editors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../../helpers/helpers.dart';

class _MockYamlEditorCubit extends MockCubit<YamlEditorState>
    implements YamlEditorCubit {}

void main() {
  group('YamlEditorView', () {
    late YamlEditorCubit yamlEditorCubit;

    setUp(() {
      yamlEditorCubit = _MockYamlEditorCubit();
      const state = YamlEditorState(
        status: EditorStatus.loading,
        savingStatus: EditorSavingStatus.saved,
        content: '',
      );
      whenListen(
        yamlEditorCubit,
        Stream.fromIterable([state]),
        initialState: state,
      );
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpSubject(yamlEditorCubit);
      expect(find.byType(YamlEditorView), findsOneWidget);
    });

    testWidgets('updates its content when loaded', (tester) async {
      const initialState = YamlEditorState(
        status: EditorStatus.loading,
        savingStatus: EditorSavingStatus.saved,
        content: '',
      );
      whenListen(
        yamlEditorCubit,
        Stream.fromIterable(
          [
            initialState,
            initialState.copyWith(
              content: 'test',
              status: EditorStatus.loaded,
            ),
          ],
        ),
        initialState: initialState,
      );

      await tester.pumpSubject(yamlEditorCubit);
      expect(find.byType(YamlEditorView), findsOneWidget);
      expect(find.text('test'), findsOneWidget);
    });

    testWidgets('calls save when saving the file', (tester) async {
      when(() => yamlEditorCubit.save(any())).thenAnswer((_) async {});
      const state = YamlEditorState(
        status: EditorStatus.loading,
        savingStatus: EditorSavingStatus.saved,
        content: 'test',
      );
      whenListen(
        yamlEditorCubit,
        Stream.fromIterable([state]),
        initialState: state,
      );
      await tester.pumpSubject(yamlEditorCubit);

      await tester.tap(
        find.descendant(
          of: find.byKey(YamlEditorView.saveIconKey),
          matching: find.byType(NesIcon),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => yamlEditorCubit.save('test')).called(1);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpSubject(
    YamlEditorCubit yamlEditorCubit,
  ) async {
    await pumpApp(
      Scaffold(
        body: BlocProvider<YamlEditorCubit>.value(
          value: yamlEditorCubit,
          child: const YamlEditorView(),
        ),
      ),
    );
  }
}
