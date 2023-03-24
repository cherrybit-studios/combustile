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
    final tilesetImage = await images.load('tileset.png');
    final tileset = Tileset(
      image: tilesetImage,
      tileSize: 16,
    );

    final map = TiledMap(
      tileset: tileset,
      size: Vector2(15, 10),
      objects: [
        RepeatObject(
          repeatingTile: const Tile(x: 1, y: 0),
          placement: AbsolutePlacement(
            position: Vector2(-4, 0),
            size: Vector2(9, 1),
          ),
        ),
        GroupObject(
          placement: AbsolutePlacement(
            position: Vector2(-3, -5),
            size: Vector2(7, 5),
          ),
          children: [
            NineBoxObject(
              srcPosition: Vector2(0, 3),
              srcSize: Vector2.all(3),
              placement: const RelativePlacement(
                top: 2,
                left: 1,
                width: 5,
                height: 3,
              ),
            ),
            HorizontalRepeatObject(
              tiles: [
                const Tile(x: 3, y: 3),
                const Tile(x: 4, y: 3),
                const Tile(x: 5, y: 3),
              ],
              placement: const RelativePlacement(
                left: 0,
                right: 0,
                top: 0,
                height: 1,
              ),
            ),
            HorizontalRepeatObject(
              tiles: [
                const Tile(x: 0, y: 5),
                const Tile(x: 1, y: 5),
                const Tile(x: 2, y: 5),
              ],
              placement: const RelativePlacement(
                left: 0,
                right: 0,
                top: 1,
                height: 1,
              ),
            ),
            SingleObject(
              tile: const Tile(x: 6, y: 3),
              placement: const RelativePlacement(
                bottom: 0,
                left: 3,
                width: 1,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    );

    await addAll(await map.build());
    camera
      ..zoom = 4
      ..followVector2(Vector2.zero());
  }
}
