import 'package:color_switch_game/run_mode/run_mode_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RunModePlayer extends PositionComponent with HasGameRef<RunModeGame> {
  RunModePlayer({
    required super.position,
    this.playerRadius = 13.5,
  }) : super(
          priority: 20,
        );

  final double playerRadius;

  final Color _color = Colors.white;

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onMount() {
    position = Vector2(0, 250);
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // render is called every frame to draw the RunModePlayer
    super.render(canvas);
    canvas.drawCircle(
      (size / 2).toOffset(),
      playerRadius,
      Paint()..color = _color,
    );
  }
}
