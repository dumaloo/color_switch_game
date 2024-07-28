import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';

class RunModePlayer extends PositionComponent {
  Vector2 _velocity = Vector2(100, 0); // Initial horizontal velocity
  final Vector2 _acceleration = Vector2(0, 1000); // Gravity
  int _jumps = 0;
  bool onGround = false;

  RunModePlayer()
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(50),
        );

  @override
  void update(double dt) {
    super.update(dt);

    if (!onGround) {
      _velocity += _acceleration * dt; // Apply gravity
    }

    position += _velocity * dt;

    // Check for ground collision and adjust
    if (position.y >= 0) {
      position.y = 0;
      onGround = true;
      _velocity.y = 0;
      _jumps = 0;
    } else {
      onGround = false;
    }

    // Ensure continuous rightward movement
    _velocity.x = 100;
  }

  void jump() {
    if (_jumps < 2) {
      _velocity.y = -500; // Jump velocity
      _jumps++;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      20,
      BasicPalette.white.paint(),
    );
  }
}
