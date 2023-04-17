import 'dart:async';

import 'package:combustile/combustile.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameWidget.controlled(gameFactory: ExampleGame.new);
  }
}

class ExampleGame extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    images.prefix = '';

    final mapFile = await assets.readFile('map.yaml');
    final map = await TiledMap.fromYaml(mapFile, images: images);

    await addAll(await map.build());
    camera
      ..zoom = 4
      ..followVector2(Vector2.zero());
  }
}
