import 'package:color_switch_game/run_mode/run_mode_brick.dart';
import 'package:color_switch_game/run_mode/run_mode_ground.dart';
import 'package:color_switch_game/run_mode/run_mode_player.dart';
import 'package:color_switch_game/run_mode/run_mode_shuriken.dart';
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
    RunModeGround(Vector2(2412, 0)),
    RunModeGround(Vector2(3015, 0)),
    RunModeGround(Vector2(3618, 0)),
    // Add more platforms as needed
  ];

  final List<RunModeBrick> bricks = [
    RunModeBrick(Vector2(200, -150)),
    RunModeBrick(Vector2(900, -150)),
    RunModeBrick(Vector2(1500, -175)),
    RunModeBrick(Vector2(2000, -160)),
    RunModeBrick(Vector2(2500, -175)),
    RunModeBrick(Vector2(3000, -150)),
    RunModeBrick(Vector2(3500, -180)),
    RunModeBrick(Vector2(4000, -150)),
    // Add more bricks as needed
  ];

  final List<RunModeShuriken> shurikens = [
    RunModeShuriken(Vector2(700, -85)),
    RunModeShuriken(Vector2(1200, -85)),
    RunModeShuriken(Vector2(1800, -85)),
    RunModeShuriken(Vector2(2300, -85)),
    RunModeShuriken(Vector2(2800, -85)),
    RunModeShuriken(Vector2(3300, -85)),
    RunModeShuriken(Vector2(3800, -85)),
    RunModeShuriken(Vector2(4300, -85)),
    // Add more shurikens as needed
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
    world.addAll(shurikens);
    // debugMode = true;
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
    player.checkCollision(
        bricks, shurikens); // Check for collisions with bricks and shrurikens
    super.update(dt);
  }
}
