import 'package:color_switch_game/classic_mode/classic_mode_page.dart';
import 'package:color_switch_game/run_mode/run_mode_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RunModePage(), // FOR NOW, WE WILL USE RunModePage
      theme: ThemeData.dark(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Switch Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ClassicModePage(),
                  ),
                );
              },
              child: const Text('Classic Mode'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RunModePage(),
                  ),
                );
              },
              child: const Text('Run Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
