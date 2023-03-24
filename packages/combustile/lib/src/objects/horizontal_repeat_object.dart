import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template horizontal_repeat_object}
/// A [CombustileObject] that repeats a horizontal section of tiles.
/// {@endtemplate}
class HorizontalRepeatObject extends CombustileObject {
  /// {@macro horizontal_repeat_object}
  HorizontalRepeatObject({
    required super.placement,
    required this.tiles,
    super.id,
  }) : assert(
          tiles.length == 3,
          'HorizontalRepeatObject must have 3 tiles',
        );

  /// The tiles that will be used to build the object.
  final List<Tile> tiles;

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
    final sprites = tiles.map((tile) => tileset.tileToSprite(tile)).toList();

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    for (var x = 0; x < size.x; x += tileset.tileSize) {
      final isFirst = x == 0;
      final isLast = x + tileset.tileSize >= size.x;

      final tile = isFirst
          ? sprites[0]
          : isLast
              ? sprites[2]
              : sprites[1];

      // ignore: cascade_invocations
      tile.render(
        canvas,
        position: Vector2(
          x.toDouble(),
          0,
        ),
      );
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.x.toInt(), size.y.toInt());
    return SpriteComponent.fromImage(
      image,
      position: Vector2(position.x, position.y),
      size: Vector2(size.x, size.y),
    );
  }
}
