import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class KBackButton extends StatelessWidget {
  const KBackButton({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onBack?.call();
        context.pop();
      },
      child: DecoContainer(
        margin: Pads.sm(),
        color: context.colors.surface,
        height: 40,
        width: 40,
        borderRadius: Corners.circle,
        child: Icon(Icons.arrow_back_rounded, color: context.colors.onSurface, size: 20),
      ),
    );
  }
}
