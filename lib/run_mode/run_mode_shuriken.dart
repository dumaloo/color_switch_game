import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class RunModeShuriken extends PositionComponent {
  RunModeShuriken(Vector2 position)
      : super(
          position: position,
          size: Vector2(60, 60), // Adjust size as needed
        );

  @override
  void render(Canvas canvas) {
    final double width = size.x;
    final double height = size.y;

    // Draw the four triangles with different colors
    _drawTriangle(canvas, width, height, const Color(0xFF00BCD4), 0);
    _drawTriangle(canvas, width, height, const Color(0xFFFFEB3B), 90);
    _drawTriangle(canvas, width, height, const Color(0xFFFF4081), 180);
    _drawTriangle(canvas, width, height, const Color(0xFF7C4DFF), 270);

    // Draw the central black circle
    final centralPaint = Paint()..color = const Color(0xFF000000);
    final double centralRadius = width * 0.25;
    canvas.drawCircle(
        Offset(width / 2, height / 2), centralRadius, centralPaint);
  }

  void _drawTriangle(Canvas canvas, double width, double height, Color color,
      double rotation) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final double centerX = width / 2;
    final double centerY = height / 2;

    // Draw a triangle that fits in one quarter of the shuriken
    path.moveTo(centerX, centerY);
    path.lineTo(centerX, centerY - height / 2); // Top point
    path.lineTo(centerX + width / 2, centerY); // Right point
    path.close();

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(rotation * 3.1415927 / 180);
    canvas.translate(-centerX, -centerY);

    canvas.drawPath(path, paint);

    canvas.restore();
  }
}
