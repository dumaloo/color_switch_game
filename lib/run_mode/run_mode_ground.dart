import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RunModeGround extends PositionComponent {
  RunModeGround()
      : super(
          position: Vector2(0, 25),
          size: Vector2(500, 30),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      BasicPalette.white.paint(),
    );
    // canvas.drawRect(
    //   Rect.fromLTWH(605, 0, size.x, size.y),
    //   BasicPalette.red.paint(),
    // );
  }
}
