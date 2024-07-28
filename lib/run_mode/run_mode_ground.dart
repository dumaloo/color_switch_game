import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RunModeGround extends PositionComponent {
  RunModeGround(Vector2 position)
      : super(
          position: position,
          size: Vector2(500, 30),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      BasicPalette.white.paint(),
    );
  }
}
