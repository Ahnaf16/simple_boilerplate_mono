import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class ReadMore extends StatelessWidget {
  const ReadMore(this.text, {super.key, this.style, this.maxLines = 3, this.moreText, this.lessText});

  final String text;
  final TextStyle? style;
  final int maxLines;
  final String? moreText;
  final String? lessText;

  @override
  Widget build(BuildContext context) {
    return AnimatedReadMoreText(
      text,
      maxLines: maxLines,
      readMoreText: ' ${moreText ?? 'Read more'}',
      readLessText: ' ${lessText ?? 'Read less'}',
      textStyle: style,
      buttonTextStyle: context.text.labelLarge!.primary,
      animationCurve: Curves.easeInOutCirc,
    );
  }
}
