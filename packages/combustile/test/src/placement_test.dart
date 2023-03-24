// ignore_for_file: prefer_const_constructors

import 'package:combustile/combustile.dart';
import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Placement', () {
    group('AbsolutePlacement', () {
      test('calculates correctly', () {
        final placement = AbsolutePlacement(
          position: Vector2.all(10),
          size: Vector2.all(10),
        );
        final parentSize = Vector2.all(100);
        final position = placement.calculatePosition(parentSize);
        final size = placement.calculateSize(parentSize);
        expect(position, Vector2.all(10));
        expect(size, Vector2.all(10));
      });
    });

    group('RelativePlacement', () {
      test('calculates correctly when using LRTB', () {
        final placement = RelativePlacement(
          left: 10,
          right: 10,
          top: 10,
          bottom: 10,
        );
        final parentSize = Vector2.all(100);
        final position = placement.calculatePosition(parentSize);
        final size = placement.calculateSize(parentSize);
        expect(position, Vector2.all(10));
        expect(size, Vector2.all(80));
      });

      test('calculates correctly when using LTWH', () {
        final placement = RelativePlacement(
          left: 10,
          top: 10,
          width: 10,
          height: 10,
        );
        final parentSize = Vector2.all(100);
        final position = placement.calculatePosition(parentSize);
        final size = placement.calculateSize(parentSize);
        expect(position, Vector2.all(10));
        expect(size, Vector2.all(10));
      });

      test('calculates correctly when using RBWH', () {
        final placement = RelativePlacement(
          right: 10,
          bottom: 10,
          width: 10,
          height: 10,
        );
        final parentSize = Vector2.all(100);
        final position = placement.calculatePosition(parentSize);
        final size = placement.calculateSize(parentSize);
        expect(position, Vector2(80, 80));
        expect(size, Vector2.all(10));
      });

      test('calculates correctly when using LRTH', () {
        final placement = RelativePlacement(
          left: 0,
          right: 0,
          top: 0,
          height: 10,
        );
        final parentSize = Vector2.all(100);
        final position = placement.calculatePosition(parentSize);
        final size = placement.calculateSize(parentSize);
        expect(position, Vector2.zero());
        expect(size, Vector2(100, 10));
      });
    });
  });
}
