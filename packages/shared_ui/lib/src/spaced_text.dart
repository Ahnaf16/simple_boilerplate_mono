import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

typedef StyleBuilder = (TextStyle, TextStyle) Function(TextStyle left, TextStyle right);

class SpacedText extends StatelessWidget {
  const SpacedText({
    super.key,
    required this.left,
    required this.right,
    this.leading,
    this.trailing,
    this.separator = ' : ',
    this.style,
    this.onTap,
    this.styleBuilder,
    this.spaced = true,
  });

  static (TextStyle, TextStyle) buildStye(left, right) => (left, right);

  final Widget? leading;
  final String left;

  /// Default style for both texts
  final TextStyle? style;
  final String right;
  final String separator;
  final Widget? trailing;
  final void Function(String left, String right)? onTap;

  /// Override style for left and right
  final StyleBuilder? styleBuilder;
  final bool spaced;

  @override
  Widget build(BuildContext context) {
    final sty = context.text.bodyMedium ?? const TextStyle();
    final defBuilder = (style ?? sty, style ?? sty);

    final (lSty, rSty) = styleBuilder?.call(style ?? sty, style ?? sty) ?? defBuilder;

    return InkWell(
      onTap: onTap == null ? null : () => onTap?.call(left, right),
      borderRadius: Corners.lgBorder,
      child: Row(
        mainAxisAlignment: spaced ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Text('$left$separator', style: lSty),
          const Gap(Insets.med),
          ...[
            if (leading != null) ...[leading!, const Gap(Insets.sm)],
            Flexible(
              child: Text(right, style: rSty, textAlign: TextAlign.end),
            ),
            if (trailing != null) ...[const Gap(Insets.sm), trailing!],
          ],
        ],
      ),
    );
  }
}
