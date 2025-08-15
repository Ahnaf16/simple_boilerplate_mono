import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class UiSection extends StatelessWidget {
  const UiSection({
    super.key,
    this.title,
    this.titleWidget,
    this.seeAllText,
    this.onSeeAll,
    required this.child,
    this.optional,
    this.titleDivider,
    this.useShadow = false,
  });

  final String? title;
  final Widget? titleWidget;
  final String? seeAllText;
  final Function()? onSeeAll;
  final Widget? titleDivider;
  final Widget child;
  final bool useShadow;

  /// if [optional] is not null this is shown instead of [child]
  ///
  /// useful when data is null/empty and want to show a message
  final Widget? Function(BuildContext context)? optional;

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: EdgeInsets.zero,
      boxShadow: useShadow ? null : [],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || titleWidget != null)
            Padding(
              padding: Pads.sm('lrt'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleWidget ?? Text(title ?? '', style: context.text.titleMedium),
                  if (onSeeAll != null)
                    GestureDetector(
                      onTap: onSeeAll,
                      child: Text(seeAllText ?? 'See all', style: context.text.bodyMedium!.primary),
                    ),
                ],
              ),
            ),
          if (title != null || titleWidget != null) titleDivider ?? const Divider(),
          optional?.call(context) ?? child,
        ],
      ),
    );
  }
}
