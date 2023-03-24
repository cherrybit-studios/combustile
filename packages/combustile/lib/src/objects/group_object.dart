import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';

/// {@template group_object}
/// A [CombustileObject] that groups other objects.
/// {@endtemplate}
class GroupObject extends CombustileObject {
  /// {@macro group_object}
  GroupObject({
    required super.placement,
    required this.children,
    super.id,
  });

  /// The [CombustileObject]s that are part of this group.
  final List<CombustileObject> children;

  @override
  Future<PositionComponent> toComponent(
    Tileset tileset,
    Vector2 parentSize,
  ) async {
    final position = tileset.project(
      placement.calculatePosition(parentSize),
    );
    final size = placement.calculateSize(parentSize);
    final childrenComponents = await Future.wait(
      children.map((child) => child.toComponent(tileset, size)),
    );

    return PositionComponent(
      position: position,
      size: tileset.project(size),
      children: childrenComponents,
    );
  }
}
