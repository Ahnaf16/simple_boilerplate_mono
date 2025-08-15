import 'package:flutter/material.dart';

class FadeAndDismiss extends StatelessWidget {
  const FadeAndDismiss({super.key, required this.isVisible, this.padding, this.duration, required this.child});

  final bool isVisible;
  final EdgeInsetsGeometry? padding;
  final Duration? duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? kThemeAnimationDuration,
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: isVisible ? Padding(padding: padding ?? EdgeInsets.zero, child: child) : const SizedBox.shrink(),
    );
  }
}
