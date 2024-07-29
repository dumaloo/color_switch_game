import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RunModeBrick extends PositionComponent {
  bool collected = false;

  RunModeBrick(Vector2 position)
      : super(
          position: position,
          size: Vector2(50, 50),
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
