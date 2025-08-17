import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size, this.showName = false, this.direction, this.name});
  final double? size;
  final bool showName;
  final Axis? direction;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction ?? Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: size),
        if (showName) ...[const Gap(Insets.sm), Text(name ?? kName)],
      ],
    );
  }
}
