import 'dart:async';

import 'package:color_switch_game/my_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleRotator extends PositionComponent with HasGameRef<MyGame> {
  CircleRotator({
    super.position,
    super.size,
    this.thickness = 8,
  }) : super(anchor: Anchor.center);

  final double thickness;

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
  }

  @override
  void render(Canvas canvas) {
    // calculate the radius of the circle
    // based on the size and thickness of the circle
    // the circle should be drawn in the center of the component
    // so the final radius is calculated by dividing the size by 2
    // and subtracting the thickness divided by 2
    // this will give the radius of the circle
    final radius = (size.x / 2) - (thickness / 2);

    // canvas.drawCircle(
    //   (size / 2).toOffset(),
    //   radius,
    //   Paint()
    //     ..color = Colors.blueAccent
    //     ..strokeWidth = thickness
    //     ..style = PaintingStyle.stroke,
    // );
    super.render(canvas);
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
    super.onMount();
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
