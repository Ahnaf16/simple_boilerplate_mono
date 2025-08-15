import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
    this.text = 'OR',
    this.height,
    this.color,
    this.thickness,
    this.indent,
    this.endIndent,
    this.gap,
  });

  final String text;
  final Color? color;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final double? gap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Pads.sym(0, height ?? Insets.sm),
      child: Row(
        spacing: gap ?? Insets.med,
        children: [
          Expanded(
            child: Container(
              height: 1,
              margin: Pads.only(left: indent ?? Insets.lg),
              color: color ?? context.colors.outline,
            ),
          ),
          Text(text),

          Expanded(
            child: Container(
              height: 1,
              margin: Pads.only(right: endIndent ?? Insets.lg),
              color: color ?? context.colors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
