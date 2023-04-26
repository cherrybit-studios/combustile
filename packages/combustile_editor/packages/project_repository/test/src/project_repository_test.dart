// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
import 'package:project_repository/project_repository.dart';
import 'package:test/test.dart';

class _MockDirectory extends Mock implements Directory {}

class _MockFile extends Mock implements File {}

void main() {
  group('ProjectRepository', () {
    late Directory directory;
    late ProjectRepository projectRepository;

    setUp(() {
      directory = _MockDirectory();
      projectRepository = ProjectRepository();
    });

    test('can be instantiated', () {
      expect(ProjectRepository(), isNotNull);
    });

    test('can load a project', () async {
      when(() => directory.path).thenReturn('/home/my_game');
      when(() => directory.list(recursive: true)).thenAnswer(
        (_) => Stream.fromIterable(
          [
            Directory('/home/my_game/assets'),
            File('/home/my_game/assets/character.png'),
            Directory('/home/my_game/src'),
            File('/home/my_game/src/character.dart'),
          ],
        ),
      );

      final project = await projectRepository.loadProject(directory);

      expect(
        project,
        equals(
          Project(
            name: 'my_game',
            path: '/home/my_game',
            entries: const [
              ProjectEntry(
                name: 'assets',
                path: '/home/my_game/assets',
                isFile: false,
              ),
              ProjectEntry(
                name: 'character.png',
                path: '/home/my_game/assets/character.png',
                isFile: true,
              ),
              ProjectEntry(
                name: 'src',
                path: '/home/my_game/src',
                isFile: false,
              ),
              ProjectEntry(
                name: 'character.dart',
                path: '/home/my_game/src/character.dart',
                isFile: true,
              ),
            ],
          ),
        ),
      );
    });

    test('throws ProjectLoadFailure when something wrong happens', () async {
      when(() => directory.list(recursive: true)).thenThrow(
        Exception('Something went wrong'),
      );

      await expectLater(
        () => projectRepository.loadProject(directory),
        throwsA(
          isA<ProjectLoadFailure>().having(
            (e) => e.toString(),
            'message',
            'ProjectLoadFailure: Exception: Something went wrong',
          ),
        ),
      );
    });

    test('can create a file', () async {
      final entry = await projectRepository.createFile(
        Directory(
          path.join(
            Directory.systemTemp.path,
          ),
        ),
        path.join(
          Directory.systemTemp.path,
          'file.dart',
        ),
      );

      expect(entry, isNotNull);
      expect(entry!.name, 'file.dart');
      expect(
        entry.path,
        path.join(
          Directory.systemTemp.path,
          'file.dart',
        ),
      );
      expect(entry.isFile, isTrue);
    });

    test('throws FileOutsideProjectException when file is outside folder',
        () async {
      await expectLater(
        () => projectRepository.createFile(
          Directory(
            path.join(
              Directory.systemTemp.path,
            ),
          ),
          path.join(
            'test',
            'file.dart',
          ),
        ),
        throwsA(
          isA<FileOutsideProjectException>().having(
            (e) => e.toString(),
            'message',
            equals(
              'FileOutsideProjectException: test/file.dart is not inside ${Directory.systemTemp.path}',
            ),
          ),
        ),
      );
    });

    test('can read a file', () async {
      final mockFile = _MockFile();
      when(mockFile.readAsString).thenAnswer(
        (_) => Future.value('Hello World'),
      );
      projectRepository = ProjectRepository(
        newFile: (path) => mockFile,
      );

      final content = await projectRepository.readFile('');
      expect(content, equals('Hello World'));
    });
  });
}
