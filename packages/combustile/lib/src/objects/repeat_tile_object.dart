import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template repeat_object}
/// A [CombustileObject] that repeats a tile to build the object itself.
/// {@endtemplate}
class RepeatObject extends CombustileObject {
  /// {@macro repeat_object}
  RepeatObject({
    required super.placement,
    required this.repeatingTile,
    super.id,
  });

  /// The tile that will be repeated to build the object.
  final Tile repeatingTile;

  @override
  Future<PositionComponent> toComponent(
    Tileset tileset,
    Vector2 parentSize,
  ) async {
    final position = tileset.project(
      placement.calculatePosition(parentSize),
    );
    final size = tileset.project(
      placement.calculateSize(parentSize),
    );
    final tile = tileset.tileToSprite(repeatingTile);

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    for (var y = 0; y < size.y; y += tileset.tileSize) {
      for (var x = 0; x < size.x; x += tileset.tileSize) {
        tile.render(
          canvas,
          position: Vector2(
            x.toDouble(),
            y.toDouble(),
          ),
        );
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.x.toInt(), size.y.toInt());
    return SpriteComponent.fromImage(
      image,
      position: position,
      size: size,
    );
  }
}
