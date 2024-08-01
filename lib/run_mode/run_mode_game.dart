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
    RunModeGround(Vector2(-400, 0)),
    RunModeGround(Vector2(0, 0)),
    RunModeGround(Vector2(603, 0)),
    RunModeGround(Vector2(1206, 0)),
    RunModeGround(Vector2(1809, 0)),
    RunModeGround(Vector2(2412, 0)),
    RunModeGround(Vector2(3015, 0)),
    RunModeGround(Vector2(3618, 0)),
  ];

  final List<RunModeBrick> bricks = [
    RunModeBrick(Vector2(250, -150)),
    RunModeBrick(Vector2(500, -150)),
    RunModeBrick(Vector2(855, -200)),
    RunModeBrick(Vector2(1250, -150)),
    RunModeBrick(Vector2(1750, -150)),
    RunModeBrick(Vector2(2100, -250)),
    RunModeBrick(Vector2(2500, -200)),
    RunModeBrick(Vector2(2800, -200)),
  ];

  final List<RunModeShuriken> shurikens = [
    RunModeShuriken(Vector2(850, -63)),
    RunModeShuriken(Vector2(1500, -63)),
    RunModeShuriken(Vector2(2000, -63)),
    RunModeShuriken(Vector2(2345, -63)),
    RunModeShuriken(Vector2(2950, -63)),
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
    camera.viewfinder.zoom = 1;
    // debugMode = true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
    super.onTapDown(event);
  }

  // Game over logic
  void gameOver() {
    for (var element in world.children) {
      element.removeFromParent();
    }
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
