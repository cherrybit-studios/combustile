import 'dart:ui';

import 'package:combustile/combustile.dart';
import 'package:flame/cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yaml/yaml.dart';

class _MockImages extends Mock implements Images {}

class _MockImage extends Mock implements Image {}

void main() {
  group('Tileset', () {
    late Images images;
    late Image image;

    setUp(() {
      images = _MockImages();

      image = _MockImage();
      when(() => images.load(any())).thenAnswer((_) async => image);
    });

    test('fromYaml', () async {
      const yamlRaw = '''
tileset:
  tile_size: 16
  image: tileset.png
''';

      final yaml = loadYaml(yamlRaw) as YamlMap;

      final tileset = await Tileset.fromYaml(yaml, images: images);

      expect(tileset.tileSize, equals(16));
      expect(tileset.image, equals(image));
    });
  });
}
