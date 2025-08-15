import 'package:flutter/material.dart';

class SelectionFrame extends StatelessWidget {
  const SelectionFrame({
    super.key,
    required this.child,
    this.selected = false,
    this.borderColor,
    this.borderWidth = 1.5,
    this.radius = 12,
    this.cornerSize = 50,
    this.cornerColor,
    this.icon = Icons.check,
    this.iconColor = Colors.white,
    this.iconSize,
  });

  final Widget child;
  final bool selected;

  final Color? borderColor;
  final double borderWidth;
  final double radius;

  final double cornerSize;
  final Color? cornerColor;

  final IconData icon;
  final Color iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CustomPaint(
        foregroundPainter: _SelectionPainter(
          selected: selected,
          borderColor: borderColor ?? (selected ? scheme.primary : scheme.outlineVariant),
          borderWidth: borderWidth,
          radius: radius,
          cornerSize: cornerSize,
          cornerColor: cornerColor ?? scheme.primary,
          icon: icon,
          iconColor: iconColor,
          iconSize: iconSize ?? 18,
        ),
        child: child,
      ),
    );
  }
}

class _SelectionPainter extends CustomPainter {
  _SelectionPainter({
    required this.selected,
    required this.borderColor,
    required this.borderWidth,
    required this.radius,
    required this.cornerSize,
    required this.cornerColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
  });

  final bool selected;
  final Color borderColor;
  final double borderWidth;
  final double radius;

  final double cornerSize;
  final Color cornerColor;

  final IconData icon;
  final Color iconColor;
  final double iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));

    if (selected) {
      final leg = cornerSize;
      final cornerRadius = Radius.circular(radius);

      // Draw rounded corner triangle
      final triPath = Path()
        ..moveTo(size.width - leg, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, leg)
        ..close();

      // Create a clip path to round the corner
      final clipPath = Path()
        ..addRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width - leg, 0, leg, leg), topRight: cornerRadius));

      // Combine the triangle with the rounded corner
      final roundedTriPath = Path.combine(PathOperation.intersect, triPath, clipPath);

      final triPaint = Paint()..color = cornerColor;
      canvas.drawPath(roundedTriPath, triPaint);

      // Draw Icon inside triangle - position it more carefully
      final iconPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: iconSize,
            fontFamily: icon.fontFamily,
            package: icon.fontPackage,
            color: iconColor,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      iconPainter.layout();

      // Position the icon within the triangle, accounting for the rounded corner
      final iconOffset = Offset(size.width - leg + (leg - iconPainter.width) * .8, (leg - iconPainter.height) * 0.2);
      iconPainter.paint(canvas, iconOffset);
    }

    // Draw border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..color = borderColor;
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _SelectionPainter old) {
    return selected != old.selected ||
        borderColor != old.borderColor ||
        borderWidth != old.borderWidth ||
        radius != old.radius ||
        cornerSize != old.cornerSize ||
        cornerColor != old.cornerColor ||
        icon != old.icon ||
        iconColor != old.iconColor ||
        iconSize != old.iconSize;
  }
}
