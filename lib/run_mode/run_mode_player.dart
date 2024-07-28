import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'run_mode_ground.dart';

class RunModePlayer extends PositionComponent {
  Vector2 _velocity = Vector2(100, 0); // Initial horizontal velocity
  final Vector2 _acceleration = Vector2(0, 800); // Gravity
  int _jumps = 0;
  final List<RunModeGround> grounds;

  RunModePlayer(this.grounds)
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(50),
        );

  @override
  void update(double dt) {
    super.update(dt);
    _velocity += _acceleration * dt;
    position += _velocity * dt;

    // Ensure the player doesn't fall through any ground
    bool onGround = false;
    for (var ground in grounds) {
      if (position.y + size.y >= ground.position.y &&
          position.y <=
              ground.position.y +
                  ground.size
                      .y && // Check if the player is above the ground platform
          position.x + size.x >= ground.position.x &&
          position.x <= ground.position.x + ground.size.x) {
        position.y = ground.position.y - size.y;
        _velocity.y = 0;
        _jumps = 0; // Reset jumps when on the ground
        onGround = true;
        break;
      }
    }

    if (!onGround) {
      _velocity.y += _acceleration.y * dt; // Apply gravity if not on the ground
    }

    _velocity.x = 100; // Keep horizontal velocity constant
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
