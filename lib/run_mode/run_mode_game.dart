import 'package:color_switch_game/run_mode/run_mode_brick.dart';
import 'package:color_switch_game/run_mode/run_mode_ground.dart';
import 'package:color_switch_game/run_mode/run_mode_player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class RunModeGame extends FlameGame with TapCallbacks {
  late RunModePlayer player;
  final List<RunModeGround> grounds = [
    RunModeGround(Vector2(0, 0)),
    RunModeGround(Vector2(603, 0)),
    RunModeGround(Vector2(1206, 0)),
    RunModeGround(Vector2(1809, 0)),
    // Add more platforms as needed
  ];

  final List<RunModeBrick> bricks = [
    RunModeBrick(Vector2(300, -150)),
    RunModeBrick(Vector2(900, -150)),
    RunModeBrick(Vector2(1500, -200)),
    // Add more bricks as needed
  ];

  RunModeGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  void onMount() {
    super.onMount();
    player = RunModePlayer(grounds);
    world.add(player);
    world.addAll(grounds);
    world.addAll(bricks);
    debugMode = true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    final cameraX = camera.viewfinder.position.x;
    final playerX = player.position.x;

    if (playerX > cameraX) {
      camera.viewfinder.position =
          Vector2(playerX, camera.viewfinder.position.y);
    }
    player.checkCollision(bricks); // Check for collisions with bricks

    super.update(dt);
  }
}
