import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template single_object}
/// A [CombustileObject] that uses a single tile to build the object.
/// {@endtemplate}
class SingleObject extends CombustileObject {
  /// {@macro single_object}
  SingleObject({
    required super.placement,
    required this.tile,
    super.id,
  });

  /// The [Tile] that is used to build this object.
  final Tile tile;

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
    final sprite = tileset.tileToSprite(tile);

    return SpriteComponent(
      sprite: sprite,
      position: position,
      size: size,
    );
  }
}
