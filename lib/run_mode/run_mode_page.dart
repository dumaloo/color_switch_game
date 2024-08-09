import 'package:color_switch_game/run_mode/run_mode_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RunModePage extends StatefulWidget {
  const RunModePage({super.key});

  @override
  State<RunModePage> createState() => _RunModePageState();
}

class _RunModePageState extends State<RunModePage> {
  late RunModeGame _myGameRunMode;
  bool _isGameOver = false;

  @override
  void initState() {
    _myGameRunMode = RunModeGame();
    _myGameRunMode.onGameOver = _handleGameOver;
    super.initState();
  }

  void _handleGameOver() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isGameOver = true;
      });
    });
  }

  void _restartGame() {
    setState(() {
      _isGameOver = false;
      _myGameRunMode = RunModeGame();
      _myGameRunMode.onGameOver = _handleGameOver;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: _myGameRunMode,
            key: UniqueKey(),
          ),
          if (_myGameRunMode.isGamePlaying)
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(_myGameRunMode.isGamePaused
                          ? Icons.play_arrow
                          : Icons.pause),
                      onPressed: () {
                        setState(() {
                          if (_myGameRunMode.isGamePaused) {
                            _myGameRunMode.resumeGame();
                          } else {
                            _myGameRunMode.pauseGame();
                          }
                        });
                      },
                    ),
                    // Display score
                    ValueListenableBuilder<int>(
                      valueListenable: _myGameRunMode.currentScore,
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
          if (_myGameRunMode.isGamePaused)
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
                          _myGameRunMode.resumeGame();
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
                  Text(
                    "SCORE: ${_myGameRunMode.currentScore.value}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
