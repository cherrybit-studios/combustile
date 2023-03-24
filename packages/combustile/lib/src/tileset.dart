import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

/// {@template tileset}
/// A tileset is a collection of tiles that can be used to create a sprite.
/// {@endtemplate}
class Tileset {
  /// {@macro tileset}
  const Tileset({
    required this.tileSize,
    required this.image,
  });

  /// The size of each tile.
  final int tileSize;

  /// The image that contains all the tiles.
  final Image image;

  /// Projects the given [value] to the tileset tile size.
  Vector2 project(Vector2 value) {
    return Vector2(
      value.x * tileSize,
      value.y * tileSize,
    );
  }

  /// Returns a section of the tileset, using the
  /// given [srcPosition] and [srcSize].
  ///
  /// Where [srcPosition] and [srcSize] are tiles indexes.
  Future<Image> getSection({
    required Vector2 srcPosition,
    required Vector2 srcSize,
  }) async {
    final projectedSrcSize = project(srcSize);
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    final rect = Rect.fromLTWH(
      srcPosition.x * tileSize,
      srcPosition.y * tileSize,
      projectedSrcSize.x,
      projectedSrcSize.y,
    );

    canvas.drawImageRect(
      image,
      rect,
      projectedSrcSize.toRect(),
      paint,
    );
    final picture = recorder.endRecording();
    return picture.toImage(
      projectedSrcSize.x.toInt(),
      projectedSrcSize.y.toInt(),
    );
  }

  /// Returns the [Sprite] for the given [tile].
  Sprite tileToSprite(Tile tile) {
    return Sprite(
      image,
      srcPosition: Vector2(
        (tile.x * tileSize).toDouble(),
        (tile.y * tileSize).toDouble(),
      ),
      srcSize: Vector2.all(tileSize.toDouble()),
    );
  }
}
