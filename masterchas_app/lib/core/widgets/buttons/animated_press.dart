import 'package:flutter/material.dart';

import '../../utils/app_haptics.dart';

/// Wraps any tappable widget with a small scale/bounce "press" micro-animation
/// plus haptic feedback, so buttons and cards across the app feel alive
/// instead of static. Drop-in replacement for GestureDetector(onTap: ...).
class AnimatedPress extends StatefulWidget {
  const AnimatedPress({
    super.key,
    required this.child,
    required this.onTap,
    this.scaleDown = 0.96,
    this.haptic = true,
  });

  final Widget child;
  final VoidCallback onTap;
  final double scaleDown;
  final bool haptic;

  @override
  State<AnimatedPress> createState() => _AnimatedPressState();
}

class _AnimatedPressState extends State<AnimatedPress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
  );
  late final Animation<double> _scale = Tween<double>(
    begin: 1,
    end: widget.scaleDown,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    if (widget.haptic) AppHaptics.tap();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
