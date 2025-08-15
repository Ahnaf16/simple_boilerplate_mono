import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class CircleImage extends StatelessWidget {
  const CircleImage(
    this.url, {
    super.key,
    this.padding,
    this.borderColor,
    this.radius = 25,
    this.useBorder = false,
    this.isAvatar = true,
  });

  final EdgeInsets? padding;
  final String url;
  final Color? borderColor;
  final double? radius;
  final bool useBorder;
  final bool isAvatar;

  @override
  Widget build(BuildContext context) {
    return DecoContainer(
      margin: padding ?? EdgeInsets.zero,
      height: (radius ?? 0) * 2,
      width: (radius ?? 0) * 2,
      clipChild: true,
      borderColor: borderColor ?? context.colors.primary,
      borderWidth: useBorder ? 1.5 : 0,
      borderRadius: 99,
      child: AspectRatio(
        aspectRatio: 1,
        child: HostedImage.square(url, isAvatar: isAvatar, dimension: (radius ?? 0) * 2),
      ),
    );
  }
}
