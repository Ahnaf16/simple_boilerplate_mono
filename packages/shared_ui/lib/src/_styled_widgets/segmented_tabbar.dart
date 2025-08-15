import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class SegmentedTabbar extends StatelessWidget {
  const SegmentedTabbar({super.key, required this.tabs, this.backgroundColor, this.foregroundColor, this.controller});
  final List<SegmentTab> tabs;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return SegmentedTabControl(
      selectedTabTextColor: context.colors.onPrimary,
      textStyle: context.text.bodyLarge,
      indicatorPadding: const EdgeInsets.all(3),
      tabTextColor: context.colors.onSurface,
      indicatorDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: foregroundColor ?? context.colors.primary,
      ),
      barDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ?? context.colors.primary,
      ),
      controller: controller,
      tabs: tabs,
    );
  }
}
