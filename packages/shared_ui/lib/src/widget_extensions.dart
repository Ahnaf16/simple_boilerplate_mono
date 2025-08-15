import 'dart:math';

import 'package:core_functionality/core_functionality.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

extension TestWiEx on Text {
  Widget required([bool isRequired = true]) {
    return Builder(
      builder: (context) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: data, style: style),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: (style ?? context.text.bodyMedium)?.copyWith(color: context.colors.error),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget get fit => FittedBox(child: this);

  Widget copyable([bool copyOnTap = false]) => clickable(
    onTap: copyOnTap ? () => Copier.copy(data) : null,
    onLongPress: !copyOnTap ? () => Copier.copy(data) : null,
  );
}

extension WidgetEx on Widget {
  Widget clickable({void Function()? onTap, void Function()? onLongPress}) {
    return GestureDetector(onTap: onTap, onLongPress: onLongPress, child: this);
  }

  Widget conditionalExpanded(bool condition, [int flex = 1]) => condition ? Expanded(flex: flex, child: this) : this;
  Widget conditionalFlexible(bool condition, [int flex = 1]) => condition ? Flexible(flex: flex, child: this) : this;

  Widget debugView() {
    if (kReleaseMode) return this;
    final colors = [...Colors.accents, ...Colors.primaries];
    return ColoredBox(color: colors[Random().nextInt(colors.length)], child: this);
  }

  Widget withSF([String? title]) => Scaffold(
    body: this,
    appBar: AppBar(title: Text(title ?? '')),
  );
}

extension SeparatedIterableEx on Iterable<Widget> {
  List<Widget> separatedBy(Widget separator, {bool includeLast = false}) {
    final result = <Widget>[];
    final iterator = this.iterator;

    if (iterator.moveNext()) {
      result.add(iterator.current);
      while (iterator.moveNext()) {
        result
          ..add(separator)
          ..add(iterator.current);
      }

      if (includeLast) {
        result.add(separator);
      }
    }

    return result;
  }

  List<Widget> gapBy(double gap) => separatedBy(Gap(gap));
}

extension ColorEX on Color {
  Color op(double opacity) => withValues(alpha: opacity);
  Color get op1 => op(.1);
  Color get op2 => op(.2);
  Color get op3 => op(.3);
  Color get op4 => op(.4);
  Color get op5 => op(.5);
  Color get op6 => op(.6);
  Color get op7 => op(.7);
  Color get op8 => op(.8);
  Color get op9 => op(.9);

  Color opb(int opacity) => blend(Colors.white, opacity);
  Color get opb1 => opb(90);
  Color get opb2 => opb(80);
  Color get opb3 => opb(70);
  Color get opb4 => opb(60);
  Color get opb5 => opb(50);
  Color get opb6 => opb(40);
  Color get opb7 => opb(30);
  Color get opb8 => opb(20);
  Color get opb9 => opb(10);

  ColorFilter toFilter() => ColorFilter.mode(this, BlendMode.srcIn);
}

extension MaterialStateSet on Set<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);
  bool get isFocused => contains(WidgetState.focused);
  bool get isPressed => contains(WidgetState.pressed);
  bool get isDragged => contains(WidgetState.dragged);
  bool get isSelected => contains(WidgetState.selected);
  bool get isScrolledUnder => contains(WidgetState.scrolledUnder);
  bool get isDisabled => contains(WidgetState.disabled);
  bool get isError => contains(WidgetState.error);
}

extension AsyncValueEx<T> on AsyncValue<T> {
  Widget build({
    required Widget Function(T data) data,
    required Widget Function() orElse,
    bool skipErrorToast = false,
  }) {
    return when(
      loading: () => Skeletonizer(ignorePointers: false, child: orElse()),
      data: data,
      error: (e, s) {
        if (!skipErrorToast) {
          if (e case final Failure f) ErrorView.onFailure(f);
        }

        return Skeletonizer(ignorePointers: false, child: orElse());
      },
    );
  }
}

extension ListAsyncValueEx<T> on AsyncValue<List<T>> {
  List<T> maybeList({bool showError = true}) {
    return maybeWhen(
      orElse: () => [],
      data: (d) => d,
      error: (e, s) {
        if (showError) {
          if (e case final Failure f) {
            ErrorView.onFailure(f);
          } else {
            Toaster.showError(e.toString());
          }
        }

        return [];
      },
    );
  }
}

extension ProvidersEx on List<ProviderOrFamily> {
  void invalidAll(WidgetRef ref) {
    for (final p in this) {
      ref.invalidate(p);
    }
  }
}
