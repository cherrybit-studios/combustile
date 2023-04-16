import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Objects', () {
    test('can parse a single object', () async {
      const yamlRaw = '''
id: test
placement:
  absolute:
    position: 12, 10
    size: 12, 10
type: single_object
tile: 3, 4
''';

      final yaml = await loadYaml(yamlRaw) as YamlMap;
      final object = await CombustileObject.fromYaml(yaml);
      expect(object, isA<SingleObject>());

      final singleObject = object as SingleObject;
      expect(singleObject.id, 'test');
      expect(singleObject.placement, isA<AbsolutePlacement>());

      final placement = singleObject.placement as AbsolutePlacement;
      expect(placement.position, equals(Vector2(12, 10)));
      expect(placement.size, equals(Vector2(12, 10)));
      expect(singleObject.tile, equals(const Tile(x: 3, y: 4)));
    });

    test('can parse a repeat object', () async {
      const yamlRaw = '''
id: test
placement:
  absolute:
    position: 12, 10
    size: 12, 10
type: repeat_object
tile: 3, 4
''';

      final yaml = await loadYaml(yamlRaw) as YamlMap;
      final object = await CombustileObject.fromYaml(yaml);
      expect(object, isA<RepeatObject>());

      final repeatObject = object as RepeatObject;
      expect(repeatObject.id, 'test');
      expect(repeatObject.placement, isA<AbsolutePlacement>());

      final placement = repeatObject.placement as AbsolutePlacement;
      expect(placement.position, equals(Vector2(12, 10)));
      expect(placement.size, equals(Vector2(12, 10)));
      expect(repeatObject.repeatingTile, equals(const Tile(x: 3, y: 4)));
    });

    test('can parse a horizontal repeat object', () async {
      const yamlRaw = '''
id: test
placement:
  absolute:
    position: 12, 10
    size: 12, 10
type: horizontal_repeat_object
tiles:
  - 3, 4
  - 4, 4
  - 5, 4
''';

      final yaml = await loadYaml(yamlRaw) as YamlMap;
      final object = await CombustileObject.fromYaml(yaml);
      expect(object, isA<HorizontalRepeatObject>());

      final horizontalRepeatObject = object as HorizontalRepeatObject;
      expect(horizontalRepeatObject.id, 'test');
      expect(horizontalRepeatObject.placement, isA<AbsolutePlacement>());

      final placement = horizontalRepeatObject.placement as AbsolutePlacement;
      expect(placement.position, equals(Vector2(12, 10)));
      expect(placement.size, equals(Vector2(12, 10)));
      expect(
        horizontalRepeatObject.tiles,
        equals(
          [
            const Tile(x: 3, y: 4),
            const Tile(x: 4, y: 4),
            const Tile(x: 5, y: 4),
          ],
        ),
      );
    });

    test('can parse a nine box object', () async {
      const yamlRaw = '''
id: test
placement:
  absolute:
    position: 12, 10
    size: 12, 10
type: nine_box_object
src_position: 3, 4
src_size: 5, 6
''';

      final yaml = await loadYaml(yamlRaw) as YamlMap;
      final object = await CombustileObject.fromYaml(yaml);
      expect(object, isA<NineBoxObject>());

      final nineBoxObject = object as NineBoxObject;
      expect(nineBoxObject.id, 'test');
      expect(nineBoxObject.placement, isA<AbsolutePlacement>());

      final placement = nineBoxObject.placement as AbsolutePlacement;
      expect(placement.position, equals(Vector2(12, 10)));
      expect(placement.size, equals(Vector2(12, 10)));
      expect(nineBoxObject.srcPosition, equals(Vector2(3, 4)));
      expect(nineBoxObject.srcSize, equals(Vector2(5, 6)));
    });

    test('can parse a group object', () async {
      const yamlRaw = '''
id: test
placement:
  absolute:
    position: 12, 10
    size: 12, 10
type: group_object 
children:
  - id: test_child
    placement:
      absolute:
        position: 12, 10
        size: 12, 10
    type: nine_box_object
    src_position: 3, 4
    src_size: 5, 6
  - id: test_child_2
    placement:
      absolute:
        position: 14, 12
        size: 14, 12
    type: nine_box_object
    src_position: 3, 5
    src_size: 6, 7
''';

      final yaml = await loadYaml(yamlRaw) as YamlMap;
      final object = await CombustileObject.fromYaml(yaml);
      expect(object, isA<GroupObject>());

      final groupObject = object as GroupObject;
      expect(groupObject.id, 'test');
      expect(groupObject.placement, isA<AbsolutePlacement>());

      final placement = groupObject.placement as AbsolutePlacement;
      expect(placement.position, equals(Vector2(12, 10)));
      expect(placement.size, equals(Vector2(12, 10)));

      final children = groupObject.children;
      expect(children, hasLength(2));

      final nineBoxObject = groupObject.children.first as NineBoxObject;
      expect(nineBoxObject.id, 'test_child');
      expect(nineBoxObject.placement, isA<AbsolutePlacement>());

      final childPlacement = nineBoxObject.placement as AbsolutePlacement;
      expect(childPlacement.position, equals(Vector2(12, 10)));
      expect(childPlacement.size, equals(Vector2(12, 10)));
      expect(nineBoxObject.srcPosition, equals(Vector2(3, 4)));
      expect(nineBoxObject.srcSize, equals(Vector2(5, 6)));

      final nineBoxObject2 = groupObject.children.last as NineBoxObject;
      expect(nineBoxObject2.id, 'test_child_2');
      expect(nineBoxObject2.placement, isA<AbsolutePlacement>());

      final childPlacement2 = nineBoxObject2.placement as AbsolutePlacement;
      expect(childPlacement2.position, equals(Vector2(14, 12)));
      expect(childPlacement2.size, equals(Vector2(14, 12)));
      expect(nineBoxObject2.srcPosition, equals(Vector2(3, 5)));
      expect(nineBoxObject2.srcSize, equals(Vector2(6, 7)));
    });
  });
}
