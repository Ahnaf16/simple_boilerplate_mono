import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:log_cat/log_cat.dart';
import 'package:shared_ui/src/src.dart';

class SubmitButton extends HookWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.height,
    this.width,
    this.padding,
    this.style,
    this.isEnable = true,
    this.dense = false,
  });

  final Function(ValueNotifier<bool> isLoading)? onPressed;

  final Widget child;
  final Widget? icon;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final bool dense;
  final bool isEnable;

  FilledButton _buttonMat(BuildContext context, ButtonStyle style, ValueNotifier<bool> isLoading) {
    return FilledButton.icon(
      style: style,
      onPressed: !isEnable
          ? null
          : () {
              try {
                if (isLoading.value) return;
                onPressed?.call(isLoading);
              } catch (e, s) {
                catErr('SubmitButton', e, s);
                isLoading.value = false;
              }
            },
      label: icon == null ? (isLoading.value ? loadingWidget(context) : child) : child,
      icon: icon == null ? null : (isLoading.value ? loadingWidget(context) : icon!),
    );
  }

  static Widget loadingWidget(BuildContext context) {
    return const LoadingIndicator.onPrimary(size: 25);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final ButtonStyle buttonStyle = style ?? FilledButton.styleFrom();

    return SafeArea(
      top: false,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          height: height ?? (dense ? 50 : 50),
          width: width ?? (dense ? null : double.infinity),
          child: _buttonMat(context, buttonStyle, isLoading),
        ),
      ),
    );
  }
}
