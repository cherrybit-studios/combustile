import 'package:bloc_test/bloc_test.dart';
import 'package:combustile_editor/editors/editors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_repository/project_repository.dart';

class _MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  group('YamlEditorCubit', () {
    late ProjectRepository projectRepository;

    setUp(() {
      projectRepository = _MockProjectRepository();
    });

    test('can be instantiated', () {
      final cubit = YamlEditorCubit(
        repository: _MockProjectRepository(),
        filePath: '',
      );
      expect(cubit, isNotNull);
    });

    test('initial state is YamlEditorState.initial', () {
      final cubit = YamlEditorCubit(
        repository: _MockProjectRepository(),
        filePath: '',
      );
      expect(
        cubit.state,
        equals(
          const YamlEditorState(
            status: EditorStatus.loading,
            content: '',
            savingStatus: EditorSavingStatus.saved,
          ),
        ),
      );
    });

    blocTest<YamlEditorCubit, YamlEditorState>(
      'can load yaml file',
      setUp: () {
        when(() => projectRepository.readFile(any())).thenAnswer(
          (_) async => 'test',
        );
      },
      build: () => YamlEditorCubit(
        repository: projectRepository,
        filePath: 'file.yaml',
      ),
      act: (cubit) => cubit.load(),
      expect: () => [
        const YamlEditorState(
          status: EditorStatus.loading,
          content: '',
          savingStatus: EditorSavingStatus.saved,
        ),
        const YamlEditorState(
          status: EditorStatus.loaded,
          content: 'test',
          savingStatus: EditorSavingStatus.saved,
        ),
      ],
    );

    blocTest<YamlEditorCubit, YamlEditorState>(
      'emits failure when file cannot be loaded',
      setUp: () {
        when(() => projectRepository.readFile(any())).thenThrow(Exception());
      },
      build: () => YamlEditorCubit(
        repository: projectRepository,
        filePath: 'file.yaml',
      ),
      act: (cubit) => cubit.load(),
      expect: () => [
        const YamlEditorState(
          status: EditorStatus.loading,
          content: '',
          savingStatus: EditorSavingStatus.saved,
        ),
        const YamlEditorState(
          status: EditorStatus.failure,
          content: '',
          savingStatus: EditorSavingStatus.saved,
        ),
      ],
    );

    blocTest<YamlEditorCubit, YamlEditorState>(
      'can write the file',
      setUp: () {
        when(() => projectRepository.writeFile(any(), any())).thenAnswer(
          (_) async {},
        );
      },
      seed: () => const YamlEditorState(
        status: EditorStatus.loaded,
        content: 'test',
        savingStatus: EditorSavingStatus.saved,
      ),
      build: () => YamlEditorCubit(
        repository: projectRepository,
        filePath: 'file.yaml',
      ),
      act: (cubit) => cubit.save('content'),
      expect: () => [
        const YamlEditorState(
          status: EditorStatus.loaded,
          content: 'test',
          savingStatus: EditorSavingStatus.saving,
        ),
        const YamlEditorState(
          status: EditorStatus.loaded,
          content: 'content',
          savingStatus: EditorSavingStatus.saved,
        ),
      ],
    );

    blocTest<YamlEditorCubit, YamlEditorState>(
      'emits failure when file cannot be written',
      setUp: () {
        when(() => projectRepository.writeFile(any(), any())).thenThrow(
          Exception(),
        );
      },
      seed: () => const YamlEditorState(
        status: EditorStatus.loaded,
        content: 'test',
        savingStatus: EditorSavingStatus.saved,
      ),
      build: () => YamlEditorCubit(
        repository: projectRepository,
        filePath: 'file.yaml',
      ),
      act: (cubit) => cubit.save('content'),
      expect: () => [
        const YamlEditorState(
          status: EditorStatus.loaded,
          content: 'test',
          savingStatus: EditorSavingStatus.saving,
        ),
        const YamlEditorState(
          status: EditorStatus.loaded,
          content: 'test',
          savingStatus: EditorSavingStatus.failure,
        ),
      ],
    );
  });
}
