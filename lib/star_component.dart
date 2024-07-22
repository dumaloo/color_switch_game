import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class StarComponent extends PositionComponent {
  late Sprite _starSprite;

  StarComponent({
    required super.position,
  }) : super(
          size: Vector2(38, 38),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _starSprite = await Sprite.load('star_icon.png');
    add(CircleHitbox(
      radius: size.x / 2,
    ));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _starSprite.render(
      canvas,
      position: size / 2,
      size: size,
      anchor: Anchor.center,
    );
  }

  void showCollectEffect() {
    // Add some effect here

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
                        _starSprite.render(
                          canvas,
                          size: (size) * (1 - particle.progress),
                          anchor: Anchor.center,
                          overridePaint: Paint()
                            ..color =
                                Colors.white.withOpacity(1 - particle.progress),
                        );
                      },
                    ));
              })),
    );

    removeFromParent();
  }
}
