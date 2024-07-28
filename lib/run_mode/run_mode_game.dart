import 'package:color_switch_game/run_mode/run_mode_ground.dart';
import 'package:color_switch_game/run_mode/run_mode_player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class RunModeGame extends FlameGame with TapCallbacks {
  late RunModePlayer player;

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
    player = RunModePlayer();
    world.add(player);
    world.add(RunModeGround());
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

    super.update(dt);
  }
}
