import 'package:color_switch_game/classic_mode/classic_mode_circle_rotator.dart';
import 'package:color_switch_game/classic_mode/classic_mode_color_switcher.dart';
import 'package:color_switch_game/classic_mode/classic_mode_ground.dart';
import 'package:color_switch_game/classic_mode/classic_mode_player.dart';
import 'package:color_switch_game/star_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class ClassicModeGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
  late ClassicModePlayer classicModePlayer;

  final List<Color> gameColors;

  final ValueNotifier<int> currentScore = ValueNotifier(0);

  bool isGameOver = false;

  ClassicModeGame(
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
  Color backgroundColor() => const Color(0xFF222222);

  @override
  void onLoad() {
    decorator = PaintDecorator.blur(0);
    FlameAudio.bgm.initialize();
    super.onLoad();
  }

  @override
  void onMount() {
    initializeClassicModeGame();
    super.onMount();
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = classicModePlayer.position.y;

    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    classicModePlayer.jump();
    super.onTapDown(event);
  }

  void initializeClassicModeGame() {
    // reset the score
    currentScore.value = 0;

    isGameOver = false;

    world.add(
      ClassicModeGround(position: Vector2(0, 280)),
    );
    world.add(classicModePlayer = ClassicModePlayer(position: Vector2(0, 250)));
    camera.moveTo(Vector2(0, 0));
    _genrateGameComponentsAsNeeded(Vector2(0, -40));
    _genrateGameComponentsAsNeeded(Vector2(0, -1400));
    _genrateGameComponentsAsNeeded(Vector2(0, -2700));
    _genrateGameComponentsAsNeeded(Vector2(0, -4000));
    _genrateGameComponentsAsNeeded(Vector2(0, -5300));
    _genrateGameComponentsAsNeeded(Vector2(0, -6600));

    FlameAudio.bgm.play('background_music.mp3');
  }

  // generateInfiniteGameComponents
  void _genrateGameComponentsAsNeeded(Vector2 generateFromPosition) {
    // generate game components as needed
    world.add(
      ColorSwitcher(
        position: generateFromPosition + Vector2(0, 200),
      ),
    );
    world.add(CircleRotator(
      position: generateFromPosition + Vector2(0, 0),
      size: Vector2(200, 200),
    ));
    world.add(StarComponent(
      position: generateFromPosition + Vector2(0, 0),
      mode: GameMode.classic,
    ));

    // generate game components as needed
    generateFromPosition += Vector2(0, -400);

    world.add(
      ColorSwitcher(
        position: generateFromPosition + Vector2(0, 200),
      ),
    );
    world.add(CircleRotator(
      position: generateFromPosition + Vector2(0, 0),
      size: Vector2(200, 200),
    ));
    world.add(StarComponent(
      position: generateFromPosition + Vector2(0, 0),
      mode: GameMode.classic,
    ));

    // generate game components as needed
    generateFromPosition += Vector2(0, -450);

    world.add(
      ColorSwitcher(
        position: generateFromPosition + Vector2(0, 200),
      ),
    );
    world.add(CircleRotator(
      position: generateFromPosition + Vector2(0, 0),
      size: Vector2(220, 220),
    ));
    world.add(CircleRotator(
      position: generateFromPosition + Vector2(0, 0),
      size: Vector2(160, 160),
    ));
    world.add(StarComponent(
      position: generateFromPosition + Vector2(0, 0),
      mode: GameMode.classic,
    ));
  }

  void gameOver() {
    FlameAudio.bgm.stop();

    isGameOver = true;

    // game over logic
    for (var element in world.children) {
      element.removeFromParent();
    }

    onGameOver?.call();

    // restart the game
    // _initializeGame();
  }

  bool get isGamePaused => timeScale == 0.0;
  bool get isGamePlaying => !isGamePaused && !isGameOver;

  void pauseGame() {
    (decorator as PaintDecorator).addBlur(10);
    timeScale = 0.0;
    FlameAudio.bgm.pause();
  }

  void resumeGame() {
    (decorator as PaintDecorator).addBlur(0);
    timeScale = 1.0;
    FlameAudio.bgm.resume();
  }

  void addScore() {
    // add score logic
    currentScore.value++;
  }

  VoidCallback? onGameOver;
}
