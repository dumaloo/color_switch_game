import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class RunModePlayer extends PositionComponent {
  RunModePlayer()
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(50),
        );

  @override
  void update(double dt) {
    super.update(dt);
    // move the player to the right
    position.x += 100 * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      Offset.zero,
      20,
      BasicPalette.white.paint(),
    );
  }
}
