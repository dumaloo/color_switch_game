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

  @override
  void initState() {
    _myGameRunMode = RunModeGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _myGameRunMode),
        ],
      ),
    );
  }
}
