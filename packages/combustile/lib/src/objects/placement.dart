import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template Placement}
/// A placement is a way to position and size a [CombustileObject] in a parent.
/// {@endtemplate}
abstract class Placement {
  /// {@macro placement}
  const Placement();

  /// Calculates the position of the object.
  Vector2 calculatePosition(Vector2 parentSize);

  /// Calculates the size of the object.
  Vector2 calculateSize(Vector2 parentSize);
}

/// {@template absolute_placement}
/// A placement that positions the object in absolute coordinates.
///
/// It ignores the parent size. And position itslef using
/// the received coordinates.
///
/// {@endtemplate}
class AbsolutePlacement extends Placement {
  /// {@macro absolute_placement}
  const AbsolutePlacement({
    required this.position,
    required this.size,
  });

  /// The position of the object.
  final Vector2 position;

  /// The size of the object.
  final Vector2 size;

  @override
  Vector2 calculatePosition(Vector2 parentSize) => position;

  @override
  Vector2 calculateSize(Vector2 parentSize) => size;
}

/// {@template relative_placement}
/// A placement that positions the object in relative coordinates
/// to the parent size.
/// {@endtemplate}
class RelativePlacement extends Placement {
  /// {@macro relative_placement}
  const RelativePlacement({
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.width,
    this.height,
  });

  /// The left position of the object.
  final double? left;

  /// The right position of the object.
  final double? right;

  /// The top position of the object.
  final double? top;

  /// The bottom position of the object.
  final double? bottom;

  /// The width of the object.
  final double? width;

  /// The height of the object.
  final double? height;

  @override
  Vector2 calculatePosition(Vector2 parentSize) {
    final position = Vector2.zero();

    final mySize = calculateSize(parentSize);

    if (left != null) {
      position.x = left!;
    } else if (right != null) {
      position.x = parentSize.x - right! - mySize.x;
    }

    if (top != null) {
      position.y = top!;
    } else if (bottom != null) {
      position.y = parentSize.y - bottom! - mySize.y;
    }

    return position;
  }

  @override
  Vector2 calculateSize(Vector2 parentSize) {
    final size = Vector2.zero();

    if (width != null) {
      size.x = width!;
    } else if (left != null && right != null) {
      size.x = parentSize.x - left! - right!;
    }

    if (height != null) {
      size.y = height!;
    } else if (top != null && bottom != null) {
      size.y = parentSize.y - top! - bottom!;
    }

    return size;
  }
}
