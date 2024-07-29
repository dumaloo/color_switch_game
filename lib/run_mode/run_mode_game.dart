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
