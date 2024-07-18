import 'package:color_switch_game/ground.dart';
import 'package:color_switch_game/my_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef<MyGame> {
  Player({
    required super.position,
    this.playerRadius = 15,
  });

  final _velocity = Vector2.zero();
  final _jumpSpeed = 350.0;
  final _gravity = 980.0;

  final double playerRadius;

  @override
  void onMount() {
    position = Vector2.zero();
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  void update(double dt) {
    // update is called every frame with the time since the last frame
    super.update(dt);

    // apply gravity
    position += _velocity * dt;

    // get the ground component
    Ground ground = gameRef.findByKeyName(Ground.keyName)!;

    // players should not go below the ground level
    if (positionOfAnchor(Anchor.bottomCenter).y > ground.position.y) {
      _velocity.setValues(0, 0);
      position = Vector2(0, ground.position.y - (height / 2));
    } else {
      // apply gravity
      _velocity.y += _gravity * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    // render is called every frame to draw the player
    super.render(canvas);
    canvas.drawCircle(
      (size / 2).toOffset(),
      playerRadius,
      Paint()..color = Colors.yellow,
    );
  }

  void jump() {
    // jump is called when the player should jump
    _velocity.y = -_jumpSpeed; // jump
  }
}
