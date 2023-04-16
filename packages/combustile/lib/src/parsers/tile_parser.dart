import 'package:combustile/combustile.dart';

/// Parses a [Tile] from a [String].
Tile parseTile(String value) {
  final parts = value.split(',');
  return Tile(
    x: int.parse(parts[0]),
    y: int.parse(parts[1]),
  );
}
