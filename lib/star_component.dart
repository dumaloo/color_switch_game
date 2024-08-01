import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

enum GameMode { classic, run }

class StarComponent extends PositionComponent with HasGameRef {
  late Sprite _starSprite;
  final GameMode mode;

  StarComponent({
    required super.position,
    required this.mode,
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
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 80;

    if (mode == GameMode.classic) {
      // Classic mode effect
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
                ),
              );
            },
          ),
        ),
      );
      removeFromParent();
    } else if (mode == GameMode.run) {
      // Run mode effect - make star big and fade away
      add(
        TimerComponent(
          period: 0.5,
          repeat: false,
          onTick: () {
            removeFromParent();
          },
        ),
      );

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
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
