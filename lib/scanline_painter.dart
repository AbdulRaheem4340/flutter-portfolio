import 'package:flutter/material.dart';

class ScanlinePainter extends CustomPainter {
  final double opacity;
  final double spacing;

  ScanlinePainter({this.opacity = 0.03, this.spacing = 3.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: opacity)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ScanlinePainter old) =>
      old.opacity != opacity || old.spacing != spacing;
}

class ScanlineOverlay extends StatelessWidget {
  final Widget child;
  final double opacity;

  const ScanlineOverlay({
    super.key,
    required this.child,
    this.opacity = 0.025,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: ScanlinePainter(opacity: opacity),
            ),
          ),
        ),
      ],
    );
  }
}