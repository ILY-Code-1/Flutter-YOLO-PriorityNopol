import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlidePageTransition extends CustomTransition {
  final bool slideUp;

  SlidePageTransition({required this.slideUp});

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: slideUp ? const Offset(0, 1) : const Offset(0, -1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }
}
