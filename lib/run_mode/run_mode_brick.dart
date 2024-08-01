import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class RunModeBrick extends PositionComponent {
  bool collected = false;
  final Paint brickPaint = Paint()..color = Colors.yellow;
  final double gap = 3;

  RunModeBrick(Vector2 position)
      : super(
          position: position,
          size: Vector2(50, 20),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw the main rectangle
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      brickPaint,
    );

    // Draw 2 rectangles below side by side with a gap
    double smallRectWidth = (size.x - gap) / 2;

    // Left small rectangle
    canvas.drawRect(
      Rect.fromLTWH(0, size.y + gap, smallRectWidth, size.y),
      brickPaint,
    );

    // Right small rectangle
    canvas.drawRect(
      Rect.fromLTWH(smallRectWidth + gap, size.y + gap, smallRectWidth, size.y),
      brickPaint,
    );
  }

  void showCollisionEffect() {
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 80;

    parent!.add(
      ParticleSystemComponent(
          position: position,
          particle: Particle.generate(
              count: 30,
              lifespan: 0.8,
              generator: (i) {
                return AcceleratedParticle(
                    acceleration: randomVector2(),
                    speed: randomVector2(),
                    child: ComputedParticle(
                      renderer: (canvas, particle) {
                        // Render the brick's particles
                        canvas.drawRect(
                          Rect.fromLTWH(
                              0, 0, size.x * (1 - particle.progress), size.y),
                          Paint()
                            ..color = Colors.yellow
                                .withOpacity(1 - particle.progress),
                        );
                      },
                    ));
              })),
    );

    removeFromParent();
  }
}
