import 'dart:async';

import 'package:color_switch_game/classic_mode/classic_mode_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleRotator extends PositionComponent with HasGameRef<ClassicModeGame> {
  CircleRotator({
    super.position,
    super.size,
    this.thickness = 8,
  }) : super(anchor: Anchor.center);

  final double thickness;
  final double rotationSpeed = 1.5;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    // add the circle arc components
    // each arc will have a different color
    // and will be drawn at a different angle
    const circle = math.pi * 2;
    final sweep = circle / gameRef.gameColors.length;
    for (int i = 0; i < gameRef.gameColors.length; i++) {
      add(CircleArc(
        color: gameRef.gameColors[i],
        // start angle is the index of the color times the sweep angle
        startAngle: i * sweep,
        // sweep angle is the angle between the colors
        sweepAngle: sweep,
      ));
    }

    // add a rotation effect to the circle
    add(
      RotateEffect.to(
          circle,
          EffectController(
            speed: rotationSpeed,
            infinite: true,
          )),
    );
  }
}

class CircleArc extends PositionComponent with ParentIsA<CircleRotator> {
  final Color color;
  final double startAngle;
  final double sweepAngle;

  CircleArc({
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  }) : super(anchor: Anchor.center);

  @override
  void onMount() {
    size = parent.size;
    position = size / 2;
    _addHitBox();
    super.onMount();
  }

  void _addHitBox() {
    // the center of the circle
    final center = size / 2;

    // how many points the polygon will have
    const precision = 8;

    // the angle between each point
    final segment = sweepAngle / (precision - 1);

    // the radius of the circle
    final radius = size.x / 2;

    List<Vector2> points = [];

    // add the points of the polygon
    // that will be used as the hitbox

    for (int i = 0; i < precision; i++) {
      // how did you draw this?
      // imagine a circle with radius 1
      // the x and y coordinates of the points
      // are the cos and sin of the angle
      // multiplied by the radius

      // the angle of the current point
      final thisSegment = startAngle + segment * i;
      points.add(
        Vector2(
          // x = center.x + radius * cos(angle)
          // y = center.y + radius * sin(angle)
          center.x + radius * math.cos(thisSegment),
          center.y + radius * math.sin(thisSegment),
        ),
      );
    }

    // for the inner circle
    for (int i = precision - 1; i >= 0; i--) {
      final thisSegment = startAngle + segment * i;
      points.add(
        Vector2(
          center.x + (radius - parent.thickness) * math.cos(thisSegment),
          center.y + (radius - parent.thickness) * math.sin(thisSegment),
        ),
      );
    }

    // add the hitbox to the component
    add(
      PolygonHitbox(
        points,
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    canvas.drawArc(
      size.toRect().deflate(parent.thickness / 2),
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = parent.thickness,
    );
    super.render(canvas);
  }
}
