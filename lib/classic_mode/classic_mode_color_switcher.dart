import 'package:color_switch_game/classic_mode/classic_mode_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorSwitcher extends PositionComponent
    with HasGameRef<ClassicModeGame>, CollisionCallbacks {
  ColorSwitcher({
    required super.position,
    this.radius = 18,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(radius * 2),
        );

  final double radius;

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox(
      position: size / 2,
      radius: radius,
      anchor: anchor,
      collisionType: CollisionType.active,
    ));
  }

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
