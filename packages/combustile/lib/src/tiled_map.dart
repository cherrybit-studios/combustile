import 'package:combustile/combustile.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:yaml/yaml.dart';

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

  /// Creates a [TiledMap] from a [yamlSource].
  static Future<TiledMap> fromYaml(
    String yamlSource, {
    Images? images,
  }) async {
    final yaml = loadYaml(yamlSource) as YamlMap;
    final imagesInstance = images ?? Flame.images;

    final map = yaml['map'] as YamlMap;

    final tilesetInstance = await Tileset.fromYaml(
      map,
      images: imagesInstance,
    );

    final size = parseVector2(map['size'] as String);

    final yamlObjects = map['objects'] as YamlList;
    final objects = await Future.wait(
      yamlObjects
          .map(
            (yamlObject) => CombustileObject.fromYaml(
              yamlObject as YamlMap,
            ),
          )
          .toList(),
    );

    return TiledMap(
      objects: objects,
      tileset: tilesetInstance,
      size: size,
    );
  }

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
