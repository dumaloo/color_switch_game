import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';

class RunModeGround extends PositionComponent {
  RunModeGround()
      : super(
          position: Vector2(-200, 23),
          size: Vector2(1000, 30),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      position.toOffset() & size.toSize(),
      BasicPalette.white.paint(),
    );
  }
}
