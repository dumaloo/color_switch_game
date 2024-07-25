import 'dart:async';

import 'package:color_switch_game/run_mode/run_mode_player.dart';
import 'package:flame/camera.dart';
import 'package:flame/game.dart';

class RunModeGame extends FlameGame<RunModeWorld> {
  RunModeGame()
      : super(
          world: RunModeWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );
}

class RunModeWorld extends World {
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(RunModePlayer());
  }
}
