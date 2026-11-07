import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;
  final Duration delay;
  final bool showCursor;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 45),
    this.delay = Duration.zero,
    this.showCursor = true,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _visibleChars = 0;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (!mounted) return;
      setState(() => _started = true);
      _typeNext();
    });
  }

  void _typeNext() {
    if (_visibleChars < widget.text.length) {
      Future.delayed(widget.speed, () {
        if (!mounted) return;
        setState(() => _visibleChars++);
        _typeNext();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_started) return const SizedBox.shrink();

    final visible = widget.text.substring(0, _visibleChars);
    final done = _visibleChars >= widget.text.length;

    return RichText(
      text: TextSpan(
        style: widget.style,
        children: [
          TextSpan(text: visible),
          if (widget.showCursor)
            TextSpan(
              text: '█',
              style: widget.style.copyWith(
                color: widget.style.color?.withValues(alpha: done ? 0.0 : 1.0),
              ),
            ),
        ],
      ),
    );
  }
}
