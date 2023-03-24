/// {@template tile}
/// A tile is a simple object that represents a position in the tileset grid.
/// {@endtemplate}
class Tile {
  /// {@macro tile}
  const Tile({
    required this.x,
    required this.y,
  });

  /// The x position of the tile in the tileset grid.
  final int x;

  /// The y position of the tile in the tileset grid.
  final int y;

  /// Generates a list of tiles in a horizontal line.
  static List<Tile> generateHorizontalList({
    required int count,
    int startX = 0,
    int startY = 0,
  }) {
    return List.generate(
      count,
      (index) => Tile(
        x: startX + index,
        y: startY,
      ),
    );
  }

  @override
  String toString() => 'Tile(x: $x, y: $y)';
}
