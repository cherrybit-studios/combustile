import 'dart:io';
import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/cache.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:path/path.dart' as path;

class FileImages extends Images {
  FileImages(this.projectPath);

  final String projectPath;

  @override
  Future<Image> load(String fileName, {String? key}) async {
    if (containsKey(fileName)) {
      return fromCache(fileName);
    } else {
      final fullFilePath = path.join(projectPath, fileName);
      final bytes = await File(fullFilePath).readAsBytes();

      final image = await decodeImageFromList(bytes);
      add(fileName, image);
      return image;
    }
  }
}

class PreviewGame extends FlameGame with PanDetector {
  PreviewGame(this.projectPath);

  final String projectPath;
  Vector2? position;

  @override
  Future<void> onLoad() async {
    images = FileImages(projectPath)..prefix = '';
  }

  @override
  void handlePanUpdate(DragUpdateDetails details) {
    position?.sub(details.delta.toVector2());
  }

  void zoomIn() {
    camera.zoom += 0.1;
  }

  void zoomOut() {
    if (camera.zoom > 0.1) {
      camera.zoom -= 0.1;
    }
  }

  Future<void> reloadYaml(String mapFile) async {
    try {
      final map = await TiledMap.fromYaml(mapFile, images: images);
      removeAll(children);
      await addAll(await map.build());

      if (position == null) {
        final totalSize = map.size * map.tileset.tileSize.toDouble();
        position = -size / 2;

        camera
          ..followVector2(position!)
          ..zoom = size.y / totalSize.y;
      }
    } catch (e) {
      // Ignoring for now, we simply don't update the map
      // if the parsing fails.
    }
  }
}
