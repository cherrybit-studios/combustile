import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';
import 'package:yaml/yaml.dart';

/// {@template combustile_object}
/// An object in a map.
/// {@endtemplate}
abstract class CombustileObject {
  /// {@macro combustile_object}
  const CombustileObject({
    this.id,
    required this.placement,
  });

  /// Parses a [CombustileObject] from a [YamlMap].
  static Future<CombustileObject> fromYaml(YamlMap yaml) async {
    final id = yaml['id'] as String?;
    final placement = parsePlacement(yaml['placement'] as YamlMap);

    final type = yaml['type'] as String;

    if (type == 'single_object') {
      final tile = parseTile(yaml['tile'] as String);
      return SingleObject(
        id: id,
        placement: placement,
        tile: tile,
      );
    } else if (type == 'repeat_object') {
      final tile = parseTile(yaml['tile'] as String);
      return RepeatObject(
        id: id,
        placement: placement,
        repeatingTile: tile,
      );
    } else if (type == 'horizontal_repeat_object') {
      final yamlTiles = yaml['tiles'] as YamlList;
      final tiles = yamlTiles.map((e) => parseTile(e as String)).toList();
      return HorizontalRepeatObject(
        id: id,
        placement: placement,
        tiles: tiles,
      );
    } else if (type == 'nine_box_object') {
      final srcSize = parseVector2(yaml['src_size'] as String);
      final srcPosition = parseVector2(yaml['src_position'] as String);

      return NineBoxObject(
        id: id,
        placement: placement,
        srcPosition: srcPosition,
        srcSize: srcSize,
      );
    } else if (type == 'group_object') {
      final yamlChildren = yaml['children'] as YamlList;
      final children = await Future.wait(
        yamlChildren
            .map((e) => CombustileObject.fromYaml(e as YamlMap))
            .toList(),
      );

      return GroupObject(
        id: id,
        placement: placement,
        children: children,
      );
    }

    throw UnimplementedError('CombustileObject.fromYaml: $type');
  }

  /// The id of the object.
  final String? id;

  /// The placement of the object.
  final Placement placement;

  /// {@template to_component}
  /// Converts the object to a [PositionComponent].
  Future<PositionComponent> toComponent(
    Tileset tileset,
    Vector2 parentSize,
  );
}
