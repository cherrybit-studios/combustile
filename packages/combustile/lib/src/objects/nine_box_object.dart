import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template nine_box_object}
/// A [CombustileObject] that uses a nine box to build the object itself.
/// {@endtemplate}
class NineBoxObject extends CombustileObject {
  /// {@macro nine_box_object}
  NineBoxObject({
    required this.srcPosition,
    required this.srcSize,
    required super.placement,
    super.id,
  });

  /// Coordinates on the tileset that defines the position of the nine box
  /// section.
  final Vector2 srcPosition;

  /// Coordinates on the tileset that defines the size of the nine box section.
  final Vector2 srcSize;

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

    final section = await tileset.getSection(
      srcPosition: srcPosition,
      srcSize: srcSize,
    );

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    final tileSize = tileset.tileSize.toDouble();

    final middleSprite = Sprite(
      section,
      srcPosition: Vector2.all(tileSize),
      srcSize: Vector2.all(tileSize),
    );

    final topSprite = Sprite(
      section,
      srcPosition: Vector2(tileSize, 0),
      srcSize: Vector2(tileSize, tileSize),
    );

    final bottomSprite = Sprite(
      section,
      srcPosition: Vector2(tileSize, tileSize * 2),
      srcSize: Vector2(tileSize, tileSize),
    );

    final leftSprite = Sprite(
      section,
      srcPosition: Vector2(0, tileSize),
      srcSize: Vector2(tileSize, tileSize),
    );

    final rightSprite = Sprite(
      section,
      srcPosition: Vector2(tileSize * 2, tileSize),
      srcSize: Vector2(tileSize, tileSize),
    );

    final topLeftSprite = Sprite(
      section,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(tileSize, tileSize),
    );

    final topRightSprite = Sprite(
      section,
      srcPosition: Vector2(tileSize * 2, 0),
      srcSize: Vector2(tileSize, tileSize),
    );

    final bottomLeftSprite = Sprite(
      section,
      srcPosition: Vector2(0, tileSize * 2),
      srcSize: Vector2(tileSize, tileSize),
    );

    final bottomRightSprite = Sprite(
      section,
      srcPosition: Vector2(tileSize * 2, tileSize * 2),
      srcSize: Vector2(tileSize, tileSize),
    );

    for (var y = 0.0; y < size.y; y += tileSize.toInt()) {
      for (var x = 0.0; x < size.x; x += tileSize.toInt()) {
        final isTop = y == 0;
        final isBottom = y + tileSize.toInt() >= size.y;
        final isLeft = x == 0;
        final isRight = x + tileSize.toInt() >= size.x;

        if (isTop) {
          topSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isBottom) {
          bottomSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isLeft) {
          leftSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isRight) {
          rightSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isTop && isLeft) {
          topLeftSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isTop && isRight) {
          topRightSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isBottom && isLeft) {
          bottomLeftSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (isBottom && isRight) {
          bottomRightSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }

        if (!isTop && !isBottom && !isLeft && !isRight) {
          middleSprite.render(
            canvas,
            position: Vector2(x, y),
            size: Vector2.all(tileSize),
          );
        }
      }
    }

    final image = await recorder.endRecording().toImage(
          size.x.toInt(),
          size.y.toInt(),
        );

    return SpriteComponent(
      sprite: Sprite(image),
      position: Vector2(position.x, position.y),
      size: Vector2(size.x, size.y),
    );
  }
}
