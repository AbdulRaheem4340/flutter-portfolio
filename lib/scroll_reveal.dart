import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginY;
  final double beginScale;
  final Curve curve;
  final double threshold;

  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.beginY = 40,
    this.beginScale = 0.98,
    this.curve = Curves.easeOutCubic,
    this.threshold = 0.08,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;
  bool _played = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _t = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reveal() {
    if (_played) return;
    _played = true;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > widget.threshold) {
          _reveal();
        }
      },
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, child) {
          final v = _t.value;
          return Opacity(
            opacity: v,
            child: Transform.translate(
              offset: Offset(0, widget.beginY * (1 - v)),
              child: Transform.scale(
                scale: widget.beginScale + (1 - widget.beginScale) * v,
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class StaggerReveal extends StatelessWidget {
  final int index;
  final Widget child;
  final int staggerMs;
  final double beginY;
  final Duration duration;

  const StaggerReveal({
    super.key,
    required this.index,
    required this.child,
    this.staggerMs = 70,
    this.beginY = 18,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      key: ValueKey('stagger-$index'),
      duration: duration,
      beginY: beginY,
      beginScale: 0.96,
      threshold: 0.05,
      child: child
          .animate(delay: (index * staggerMs).ms)
          .fadeIn(duration: 450.ms, curve: Curves.easeOut)
          .slideY(
            begin: 0.12,
            end: 0,
            duration: 550.ms,
            curve: Curves.easeOutCubic,
          )
          .scale(
            begin: const Offset(0.96, 0.96),
            end: const Offset(1, 1),
            duration: 550.ms,
            curve: Curves.easeOut,
          ),
    );
  }
}