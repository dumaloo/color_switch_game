import 'package:color_switch_game/circle_rotator.dart';
import 'package:color_switch_game/color_switcher.dart';
import 'package:color_switch_game/ground.dart';
import 'package:color_switch_game/my_game.dart';
import 'package:color_switch_game/star_component.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  Player({
    required super.position,
    this.playerRadius = 13.5,
  }) : super(
          priority: 20,
        );

  final _velocity = Vector2.zero();
  final _jumpSpeed = 350.0;
  final _gravity = 980.0;

  final double playerRadius;

  Color _color = Colors.white;

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox(
      radius: playerRadius,
      anchor: anchor,
      collisionType: CollisionType.active,
    ));
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
      Paint()..color = _color,
    );
  }

  void jump() {
    // jump is called when the player should jump
    _velocity.y = -_jumpSpeed; // jump
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is ColorSwitcher) {
      other.removeFromParent();
      _changeColorRandomly();
    } else if (other is CircleArc) {
      if (other.color != _color) {
        // game over logic
        gameRef.gameOver();
      }
    } else if (other is StarComponent) {
      other.showCollectEffect();
      // add score
      gameRef.addScore();
    }
  }

  void _changeColorRandomly() {
    // change the color of the player randomly
    _color = gameRef.gameColors.random();
  }
}
