import 'dart:math';

import 'package:flutter/material.dart';


class GlitchTearClipper extends CustomClipper<Path> {
  final int seed;
  GlitchTearClipper({this.seed = 7});

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final random = Random(seed);

    path.lineTo(0, h - 60);

    
    double x = 0;
    while (x < w) {
      final stepWidth = 20.0 + random.nextDouble() * 80;
      final stepHeight = 10.0 + random.nextDouble() * 50;
      final double nextX = (x + stepWidth).clamp(0, w);

      
      path.lineTo(nextX, h - 60 + stepHeight * (random.nextBool() ? 1 : -1));
      
      if (nextX < w) {
        path.lineTo(nextX, h - 60 + random.nextDouble() * 40);
      }
      x = nextX;
    }

    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant GlitchTearClipper oldClipper) =>
      oldClipper.seed != seed;
}


class CircuitClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.lineTo(0, h - 50);

    
    path.lineTo(w * 0.08, h - 50);
    path.lineTo(w * 0.08, h - 30);
    path.lineTo(w * 0.15, h - 30);
    path.lineTo(w * 0.15, h - 55);
    path.lineTo(w * 0.25, h - 55);
    path.lineTo(w * 0.25, h - 15);
    path.lineTo(w * 0.35, h - 15);
    path.lineTo(w * 0.35, h - 40);
    path.lineTo(w * 0.50, h - 40);
    path.lineTo(w * 0.50, h - 8);
    path.lineTo(w * 0.62, h - 8);
    path.lineTo(w * 0.62, h - 35);
    path.lineTo(w * 0.75, h - 35);
    path.lineTo(w * 0.75, h - 12);
    path.lineTo(w * 0.88, h - 12);
    path.lineTo(w * 0.88, h - 45);
    path.lineTo(w, h - 45);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}


class SoftDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height + 10,
      size.width,
      size.height - 35,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
