import 'package:color_switch_game/my_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorSwitcher extends PositionComponent with HasGameRef<MyGame> {
  ColorSwitcher({
    required super.position,
    this.radius = 18,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(radius * 2),
        );

  final double radius;

  @override
  void render(Canvas canvas) {
    final length = gameRef.gameColors.length;
    final sweepAngle = (math.pi * 2) / gameRef.gameColors.length;
    for (int i = 0; i < length; i++) {
      canvas.drawArc(
        size.toRect(),
        i * sweepAngle,
        sweepAngle,
        true,
        Paint()..color = gameRef.gameColors[i],
      );
    }
  }
}
