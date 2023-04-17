import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yaml/yaml.dart';

class _MockImages extends Mock implements Images {}

class _MockImage extends Mock implements Image {}

void main() {
  group('TiledMap', () {
    late Images images;
    late Image image;

    setUp(() {
      images = _MockImages();

      image = _MockImage();
      when(() => images.load(any())).thenAnswer((_) async => image);
    });

    test('fromYaml', () async {
      const yamlRaw = '''
map:
  size: 200, 300
  tileset:
    tile_size: 16
    image: tileset.png
  objects:
    - id: test
      placement:
        absolute:
          position: 12, 10
          size: 12, 10
      type: single_object
      tile: 3, 4
    - id: test_2
      placement:
        absolute:
          position: 12, 10
          size: 12, 10
      type: single_object
      tile: 3, 4
''';

      final map = await TiledMap.fromYaml(yamlRaw, images: images);

      expect(map.size, equals(Vector2(200, 300)));
      expect(map.tileset.tileSize, equals(16));
      expect(map.tileset.image, equals(image));
      expect(map.objects, hasLength(2));
    });
  });
}
