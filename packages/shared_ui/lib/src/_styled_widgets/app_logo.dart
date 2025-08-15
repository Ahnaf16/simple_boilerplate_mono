import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size, this.showName = false, this.direction});
  final double? size;
  final bool showName;
  final Axis? direction;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction ?? Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: size),
        if (showName) ...[const Gap(Insets.sm), const Text(kAppName)],
      ],
    );
  }
}
