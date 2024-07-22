import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
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
    _starSprite = await Sprite.load('star.png');
    decorator.addLast(PaintDecorator.tint(Colors.white));
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
}
