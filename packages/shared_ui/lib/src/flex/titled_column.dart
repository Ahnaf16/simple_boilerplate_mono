import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class TitledColumn extends StatelessWidget {
  const TitledColumn({super.key, this.title, required this.children, this.separatorBuilder, this.titleAction})
    : itemCount = children.length,
      itemBuilder = null;

  const TitledColumn.builder({
    super.key,
    this.title,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.titleAction,
  }) : children = const [];

  final List<Widget> children;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final int itemCount;
  final WidgetBuilder? separatorBuilder;
  final Widget? title;
  final Widget? titleAction;

  @override
  Widget build(BuildContext context) {
    return DecoContainer(
      borderRadius: Corners.lg,
      color: context.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: Pads.sm(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [title!, titleAction ?? const SizedBox.shrink()],
              ),
            ),
          if (title != null) const Divider(height: 0),
          ListView.separated(
            separatorBuilder: (context, index) => separatorBuilder?.call(context) ?? const SizedBox.shrink(),
            itemCount: itemCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: itemBuilder ?? (c, i) => children[i],
          ),
        ],
      ),
    );
  }
}
