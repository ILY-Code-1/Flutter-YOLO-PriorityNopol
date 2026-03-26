import 'package:flutter/material.dart';

enum ArrowDirection { up, down }

class AnimatedArrow extends StatefulWidget {
  final ArrowDirection direction;
  final VoidCallback onTap;

  const AnimatedArrow({
    super.key,
    required this.direction,
    required this.onTap,
  });

  @override
  State<AnimatedArrow> createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.direction == ArrowDirection.up
        ? Icons.keyboard_arrow_up_rounded
        : Icons.keyboard_arrow_down_rounded;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final offset = widget.direction == ArrowDirection.up
              ? -_animation.value
              : _animation.value;
          return Transform.translate(
            offset: Offset(0, offset),
            child: child,
          );
        },
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }
}
