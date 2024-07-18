import 'package:color_switch_game/ground.dart';
import 'package:color_switch_game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;

  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  Color backgroundColor() => Color(0xFF222222);

  @override
  void onMount() {
    world.add(
      Ground(position: Vector2(0, 400)),
    );
    world.add(myPlayer = Player());
    super.onMount();
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = myPlayer.position.y;

    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }
}
