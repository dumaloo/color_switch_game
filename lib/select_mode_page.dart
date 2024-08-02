import 'package:color_switch_game/bgm_manager.dart';
import 'package:color_switch_game/classic_mode/classic_mode_page.dart';
import 'package:color_switch_game/run_mode/run_mode_page.dart';
import 'package:flutter/material.dart';

class SelectModePage extends StatelessWidget {
  const SelectModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: InkWell(
                onTap: () {
                  BgmManager.stop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ClassicModePage(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'CLASSIC MODE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: InkWell(
                onTap: () {
                  BgmManager.stop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RunModePage(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'RUN MODE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
