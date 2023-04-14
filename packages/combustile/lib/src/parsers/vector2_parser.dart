import 'package:flame/components.dart';

/// Parses a [Vector2] from a [String].
Vector2 parseVector2(String value) {
  final parts = value.split(',');
  return Vector2(
    double.parse(parts[0]),
    double.parse(parts[1]),
  );
}
