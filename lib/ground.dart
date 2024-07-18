import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent {
  static const String keyName = 'single_ground_key';

  Ground({required super.position})
      : super(
          size: Vector2(200, 2),
          anchor: Anchor.center,
          key: ComponentKey.named(keyName),
        );

  late Sprite fingerSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    fingerSprite = await Sprite.load('finger.png');
  }

  @override
  void render(Canvas canvas) {
    fingerSprite.render(
      canvas,
      size: Vector2(100, 100),
      position: Vector2(57, 0),
    );

    super.render(canvas);
  }
}
