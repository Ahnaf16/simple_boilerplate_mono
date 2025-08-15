import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class ShadowContainer extends ConsumerWidget {
  const ShadowContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.color,
    this.height,
    this.width,
    this.boxShadow,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final double? height;
  final double? width;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(borderRadius: borderRadius ?? Corners.medBorder),
        color: color ?? context.colors.surface,
        shadows: boxShadow ?? [BoxShadow(color: context.colors.onSurface.op(.1), blurRadius: 8)],
      ),
      padding: padding ?? Pads.sm(),
      child: child,
    );
  }
}
