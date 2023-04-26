import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;

typedef CreateFile = File Function(String path);

class FileManager {
  const FileManager({
    CreateFile createFile = File.new,
  }) : _createFile = createFile;

  final CreateFile _createFile;

  Future<Uint8List> loadFileBytes(String path) =>
      _createFile(path).readAsBytes();

  String fileName(String filePath) {
    return path.basename(filePath);
  }

  bool isImage(String filePath) {
    final ext = path.extension(filePath);
    return ext == '.png' || ext == '.jpg' || ext == '.jpeg';
  }

  bool isYaml(String filePath) {
    final ext = path.extension(filePath);
    return ext == '.yml' || ext == '.yaml';
  }
}
