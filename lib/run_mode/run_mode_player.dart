import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'run_mode_ground.dart';

class RunModePlayer extends PositionComponent {
  Vector2 _velocity = Vector2(100, 0); // Initial horizontal velocity
  final Vector2 _acceleration = Vector2(0, 500); // Gravity
  int _jumps = 0;
  final List<RunModeGround> grounds;
  bool _hasfallen = false;

  static const double fallthreshold = 1000.0;

  RunModePlayer(this.grounds)
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(50),
        ) {
    // ensure player starts above the ground
    if (grounds.isNotEmpty) {
      position.y = grounds.first.position.y - size.y;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_hasfallen) {
      return;
    }

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

    // Check if player has fallen off the screen
    if (position.y > fallthreshold) {
      _hasfallen = true;
      _velocity = Vector2.zero();
    }
  }

  void jump() {
    if (_jumps < 2 && !_hasfallen) {
      // prevent jumping if player has fallen
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
