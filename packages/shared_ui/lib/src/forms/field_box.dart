import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class FieldBox extends StatelessWidget {
  const FieldBox({
    super.key,
    this.hint,
    this.title,
    this.value,
    this.hintStyle,
    this.titleStyle,
    this.trailing,
    this.color,
    this.padding,
    this.onTap,
    this.maxLines = 1,
    this.borderRadius = Corners.med,
    this.isRequired = false,
    this.valueWidget,
  });
  final String? hint;
  final String? title;
  final String? value;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final Widget? trailing;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final int? maxLines;
  final double borderRadius;
  final bool isRequired;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Insets.sm,
      children: [
        if (title != null) Text(title!, style: titleStyle ?? context.text.bodyLarge).required(isRequired),
        GestureDetector(
          onTap: onTap,
          child: DecoContainer(
            color: color ?? context.colors.surfaceContainer,
            borderRadius: borderRadius,
            padding: padding ?? Pads.sym(15, 12),
            child: Row(
              spacing: Insets.med,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: DefaultTextStyle(
                    style: hintStyle ?? context.text.bodyLarge!.op(value == null ? 0.6 : 1),
                    child: value != null ? (valueWidget ?? Text(value ?? '')) : Text(hint ?? '', maxLines: maxLines),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
