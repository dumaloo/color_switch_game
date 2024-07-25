import 'package:color_switch_game/classic_mode/classic_mode_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ClassicModePage extends StatefulWidget {
  const ClassicModePage({super.key});

  @override
  State<ClassicModePage> createState() => _ClassicModePageState();
}

class _ClassicModePageState extends State<ClassicModePage> {
  late MyGame _myGame;
  bool _isGameOver = false;

  @override
  void initState() {
    _myGame = MyGame();
    _myGame.onGameOver = _handleGameOver;
    super.initState();
  }

  void _handleGameOver() {
    setState(() {
      _isGameOver = true;
    });
  }

  void _restartGame() {
    setState(() {
      _isGameOver = false;
      _myGame.initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _myGame),
          if (_myGame.isGamePlaying)
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(_myGame.isGamePaused
                          ? Icons.play_arrow
                          : Icons.pause),
                      onPressed: () {
                        setState(() {
                          _myGame.pauseGame();
                        });
                      },
                    ),
                    // display score
                    ValueListenableBuilder<int>(
                      valueListenable: _myGame.currentScore,
                      builder: (context, score, child) {
                        return Text(
                          score.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (_myGame.isGamePaused)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "PAUSED!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _myGame.resumeGame();
                        });
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 100,
                      )),
                ],
              ),
            ),
          if (_isGameOver)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "PLAY AGAIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: _restartGame,
                    icon: const Icon(
                      Icons.replay,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
