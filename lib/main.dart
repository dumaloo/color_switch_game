import 'package:color_switch_game/classic_mode/classic_mode_page.dart';
import 'package:color_switch_game/run_mode/run_mode_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData.dark(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                children: [
                  // Color Switch Replica

                  // COLOR
                  TextSpan(
                      text: 'C', style: TextStyle(color: Colors.redAccent)),
                  TextSpan(
                      text: 'O', style: TextStyle(color: Colors.orangeAccent)),
                  TextSpan(
                      text: 'L', style: TextStyle(color: Colors.yellowAccent)),
                  TextSpan(
                      text: 'O', style: TextStyle(color: Colors.greenAccent)),
                  TextSpan(
                      text: 'R', style: TextStyle(color: Colors.blueAccent)),

                  // having space between the words
                  TextSpan(text: ' ', style: TextStyle(color: Colors.white)),

                  // SWITCH
                  TextSpan(
                      text: 'S', style: TextStyle(color: Colors.purpleAccent)),
                  TextSpan(
                      text: 'W', style: TextStyle(color: Colors.pinkAccent)),
                  TextSpan(
                      text: 'I', style: TextStyle(color: Colors.cyanAccent)),
                  TextSpan(
                      text: 'T', style: TextStyle(color: Colors.limeAccent)),
                  TextSpan(
                      text: 'C', style: TextStyle(color: Colors.indigoAccent)),
                  TextSpan(
                      text: 'H', style: TextStyle(color: Colors.tealAccent)),

                  // for getting the next word in next line
                  TextSpan(text: '\n'),

                  // for making the replica in center
                  TextSpan(text: '     '),

                  // REPLICA
                  TextSpan(
                      text: 'R', style: TextStyle(color: Colors.redAccent)),
                  TextSpan(
                      text: 'E', style: TextStyle(color: Colors.orangeAccent)),
                  TextSpan(
                      text: 'P', style: TextStyle(color: Colors.yellowAccent)),
                  TextSpan(
                      text: 'L', style: TextStyle(color: Colors.greenAccent)),
                  TextSpan(
                      text: 'I', style: TextStyle(color: Colors.blueAccent)),
                  TextSpan(
                      text: 'C', style: TextStyle(color: Colors.purpleAccent)),
                  TextSpan(
                      text: 'A', style: TextStyle(color: Colors.pinkAccent)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(300, 300),
                        painter: NestedCircleRotatorPainter(_controller.value),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ClassicModePage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.play_arrow,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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

class NestedCircleRotatorPainter extends CustomPainter {
  final double progress;

  NestedCircleRotatorPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    const colorsList = [
      // have 4 diff color circle rotator
      [Colors.red, Colors.green, Colors.blue, Colors.yellow],
      [Colors.green, Colors.blue, Colors.yellow, Colors.red],
      [Colors.blue, Colors.yellow, Colors.red, Colors.green],
      [Colors.yellow, Colors.red, Colors.green, Colors.blue],
    ];

    final radiusStep = size.width / 16;
    final baseRadius = size.width / 4;

    for (int j = 0; j < colorsList.length; j++) {
      final colors = colorsList[j];
      final segmentAngle = (2 * math.pi) / colors.length;
      final startAngle = progress * 2 * math.pi;

      for (int i = 0; i < colors.length; i++) {
        paint.color = colors[i];
        canvas.drawArc(
          Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: baseRadius + j * radiusStep,
          ),
          startAngle + (i * segmentAngle),
          segmentAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(NestedCircleRotatorPainter oldDelegate) => true;
}
