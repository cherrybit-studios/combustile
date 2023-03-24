# Combustile

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A simple tile system, that provides a declarative API, with Flame Component System in mind

## Installation 💻

**❗ In order to start using Combustile you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Add `combustile` to your `pubspec.yaml`:

```yaml
dependencies:
  combustile:
```

Install it:

```sh
flutter packages get
```

## How to use it

To create a tiled map with combustile, you first need to a `TiledMap` containing a tileset, example:

```dart
final tilesetImage = await images.load('tileset.png');
final tileset = Tileset(
  image: tilesetImage,
  tileSize: 16,
);

final map = TiledMap(
  size: Vector2(15, 10),
  tileset: tileset,
  objects: [],
);
```

Then you can fill your map with different objects. Objects are classes that uses tiles from the tileset
to create components for you game.

Which object has a different type of technique, `RepeatObject` for example will repeat a given tile inside
its area, while `SingleObject` will use a single tile to renders its full size.

Check our [example](./example) for a more complete example.

---

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
