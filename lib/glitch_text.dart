import 'dart:math';

import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration interval;
  final Duration glitchDuration; 

  const GlitchText({
    super.key,
    required this.text,
    required this.style,
    this.interval = const Duration(milliseconds: 500),
  this.glitchDuration = const Duration(milliseconds: 650),
  });

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _glitching = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _glitching = false);
      }
    });
    _scheduleGlitch();
  }

  void _scheduleGlitch() {
    Future.delayed(
      widget.interval + Duration(milliseconds: Random().nextInt(2000)),
      () {
        if (!mounted) return;
        setState(() => _glitching = true);
        _controller.forward(from: 0);
        _scheduleGlitch();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_glitching) {
      return Text(widget.text, style: widget.style);
    }

    final r = Random();
    final dx = (r.nextDouble() * 4 - 2);
    final dy = (r.nextDouble() * 2 - 1);

    return Stack(
      children: [
        
        Text(
          widget.text,
          style: widget.style.copyWith(
            color: Colors.red.withValues(alpha: 0.5),
          ),
        ),
        
        Transform.translate(
          offset: Offset(dx * 2, dy),
          child: Text(
            widget.text,
            style: widget.style.copyWith(
              color: Colors.blue.withValues(alpha: 0.4),
            ),
          ),
        ),
        
        Transform.translate(
          offset: Offset(-dx, -dy),
          child: Text(widget.text, style: widget.style),
        ),
      ],
    );
  }
}
