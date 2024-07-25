import 'package:color_switch_game/run_mode/run_mode_player.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RunModeGame extends FlameGame with TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF222222);

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onMount() {
    world.add(RunModePlayer(position: Vector2(0, 250)));
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
  }
}
