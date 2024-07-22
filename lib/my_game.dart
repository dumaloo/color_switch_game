import 'package:color_switch_game/circle_rotator.dart';
import 'package:color_switch_game/color_switcher.dart';
import 'package:color_switch_game/ground.dart';
import 'package:color_switch_game/player.dart';
import 'package:color_switch_game/star_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
  late Player myPlayer;

  final List<Color> gameColors;

  final ValueNotifier<int> currentScore = ValueNotifier(0);

  MyGame(
      {this.gameColors = const [
        Colors.redAccent,
        Colors.greenAccent,
        Colors.blueAccent,
        Colors.yellowAccent,
      ]})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  Color backgroundColor() => Color(0xFF222222);

  @override
  void onLoad() {
    decorator = PaintDecorator.blur(0);
    super.onLoad();
  }

  @override
  void onMount() {
    _initializeGame();
    super.onMount();
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = myPlayer.position.y;

    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  void _initializeGame() {
    // reset the score
    currentScore.value = 0;

    world.add(
      Ground(position: Vector2(0, 400)),
    );
    world.add(myPlayer = Player(position: Vector2(0, 250)));
    camera.moveTo(Vector2(0, 0));
    _generateGameComponents();
  }

  void _generateGameComponents() {
    world.add(ColorSwitcher(position: Vector2(0, 200)));
    world.add(CircleRotator(
      position: Vector2(0, 0),
      size: Vector2(200, 200),
    ));
    world.add(StarComponent(
      position: Vector2(0, 0),
    ));
    world.add(ColorSwitcher(position: Vector2(0, -200)));
    world.add(CircleRotator(
      position: Vector2(0, -400),
      size: Vector2(180, 180),
    ));
    world.add(CircleRotator(
      position: Vector2(0, -400),
      size: Vector2(210, 210),
    ));
    world.add(StarComponent(
      position: Vector2(0, -400),
    ));
  }

  void gameOver() {
    // game over logic
    for (var element in world.children) {
      element.removeFromParent();
    }

    // restart the game
    _initializeGame();
  }

  bool get isGamePaused => timeScale == 0.0;
  bool get isGamePlaying => !isGamePaused;

  void pauseGame() {
    (decorator as PaintDecorator).addBlur(10);
    timeScale = 0.0;
  }

  void resumeGame() {
    (decorator as PaintDecorator).addBlur(0);
    timeScale = 1.0;
  }

  void addScore() {
    // add score logic
    currentScore.value++;
  }
}
