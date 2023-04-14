import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('parsePlacement', () {
    test('can parse an absolute placement', () {
      const yamlString = '''
absolute:
  position: 12, 10
  size: 12, 10
''';
      final yaml = loadYaml(yamlString) as YamlMap;
      final placement = parsePlacement(yaml);
      expect(placement, isA<AbsolutePlacement>());

      final absolutePlacement = placement as AbsolutePlacement;
      expect(absolutePlacement.position, equals(Vector2(12, 10)));
      expect(absolutePlacement.size, equals(Vector2(12, 10)));
    });

    test('can parse a relative placement', () {
      const yamlString = '''
relative:
  left: 10
  top: 11
  right: 12
  bottom: 13
  width: 14
  height: 15
''';
      final yaml = loadYaml(yamlString) as YamlMap;
      final placement = parsePlacement(yaml);
      expect(placement, isA<RelativePlacement>());

      final relativePlacement = placement as RelativePlacement;
      expect(relativePlacement.left, equals(10));
      expect(relativePlacement.top, equals(11));
      expect(relativePlacement.right, equals(12));
      expect(relativePlacement.bottom, equals(13));
      expect(relativePlacement.width, equals(14));
      expect(relativePlacement.height, equals(15));
    });
  });
}
