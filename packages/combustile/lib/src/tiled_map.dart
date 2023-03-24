import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template tiled_map}
/// A Map that holds a collection of [CombustileObject]s and a [Tileset].
/// {@endtemplate}
class TiledMap {
  /// {@macro tiled_map}
  TiledMap({
    required this.objects,
    required this.tileset,
    required this.size,
  });

  /// The [CombustileObject]s that are part of this map.
  final List<CombustileObject> objects;

  /// The [Tileset] that is used by this map.
  final Tileset tileset;

  /// The size of this map in tile count.
  final Vector2 size;

  /// Builds a list of [PositionComponent]s from this map.
  Future<List<PositionComponent>> build() {
    return Future.wait(
      objects
          .map(
            (object) => object.toComponent(
              tileset,
              size,
            ),
          )
          .toList(),
    );
  }
}
