import 'dart:math';
import 'package:flutter/material.dart';

class GrainPainter extends CustomPainter {
  final double opacity;
  final int seed;

  GrainPainter({this.opacity = 0.045, this.seed = 42});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(seed);
    final paint = Paint()..style = PaintingStyle.fill;

    // sparse film grain
    final count = (size.width * size.height / 280).floor().clamp(400, 2200);
    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final a = random.nextDouble() * opacity;
      paint.color = Colors.black.withValues(alpha: a);
      canvas.drawRect(Rect.fromLTWH(x, y, 1.1, 1.1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GrainPainter oldDelegate) =>
      oldDelegate.opacity != opacity || oldDelegate.seed != seed;
}

class GrainOverlay extends StatelessWidget {
  final Widget child;
  final double opacity;

  const GrainOverlay({
    super.key,
    required this.child,
    this.opacity = 0.04,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: GrainPainter(opacity: opacity),
            ),
          ),
        ),
      ],
    );
  }
}