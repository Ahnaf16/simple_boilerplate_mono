import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:shared_ui/src/forms/drop_down_list.dart/drop_down.dart';
import 'package:shared_ui/src/forms/drop_down_list.dart/drop_down_list_search.dart';
import 'package:shared_ui/src/forms/field_box.dart';
import 'package:shared_ui/src/k_chip.dart';
import 'package:shared_ui/src/loading.dart';
import 'package:shared_ui/src/widget_extensions.dart';

class DropDownList<T> extends HookWidget {
  const DropDownList({
    super.key,
    this.value,
    this.values,
    required this.data,
    required this.uniqueBuilder,
    this.builder,
    this.searchFn,
    this.onChanged,
    this.onChangeMulti,
    this.hintText,
    this.title,
    this.borderRadius,
    this.isRequired = false,
    this.isMulti = false,
    this.itemBuilder,
    this.enabled = true,
  });

  final T? value;
  final List<T>? values;
  final List<T> data;
  final String Function(T value)? builder;
  final Widget Function(T value)? itemBuilder;
  final bool Function(T value, String query)? searchFn;
  final String Function(T value) uniqueBuilder;
  final Function(T? value)? onChanged;
  final Function(List<T> value)? onChangeMulti;
  final String? hintText;
  final String? title;
  final double? borderRadius;
  final bool isRequired;
  final bool isMulti;
  final bool enabled;

  String? _titleBuilder(T? value, List<T> values) {
    if (isMulti) {
      return values.isEmpty ? null : values.map((e) => builder?.call(e)).join(', ');
    } else {
      return value == null ? null : builder?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = useState<T?>(value);
    final selectedMulti = useState<List<T>>(values ?? []);
    useEffect(() {
      selected.value = value;
      selectedMulti.value = values ?? [];
      return null;
    }, [value, values]);

    final enabled = this.enabled && data.isNotEmpty;

    return AnimatedOpacity(
      duration: 250.ms,
      opacity: enabled ? 1 : 0.5,
      child: FieldBox(
        isRequired: true,
        color: context.colors.surface.op(enabled ? 1 : .7),
        title: title,
        hint: hintText,
        titleStyle: context.text.bodyMedium,
        trailing: const Icon(Icons.arrow_drop_down_rounded),
        value: _titleBuilder(selected.value, selectedMulti.value),
        valueWidget: !isMulti
            ? null
            : Wrap(
                spacing: Insets.xs,
                runSpacing: Insets.xs,
                children: [
                  for (var i in selectedMulti.value)
                    RemovableChip(
                      text: builder?.call(i) ?? i.toString(),
                      value: i,
                      onDelete: (v) {
                        selectedMulti.value = selectedMulti.value
                            .where((e) => uniqueBuilder(e) != uniqueBuilder(v))
                            .toList();
                        onChangeMulti?.call(selectedMulti.value);
                      },
                    ),
                ],
              ),
        onTap: () async {
          if (!enabled) return;
          final unique = selected.value == null ? null : uniqueBuilder(selected.value as T);
          final uniqueMulti = selectedMulti.value.map((e) => uniqueBuilder.call(e));
          final state = DropDownState<T>(
            dropDown: DropDown<T>(
              data: [
                if (isMulti)
                  ...data.map((e) => SelectedListItem<T>(data: e, isSelected: uniqueMulti.contains(uniqueBuilder(e))))
                else
                  ...data.map((e) => SelectedListItem<T>(data: e, isSelected: (unique == uniqueBuilder(e)))),
              ],

              onSelected: (s) {
                if (isMulti) {
                  onChangeMulti?.call(s.map((e) => e.data).toList());
                  selected.set(null);
                  selectedMulti.value = s.map((e) => e.data).toList();
                } else {
                  final data = s.firstOrNull?.data;

                  onChanged?.call(data);
                  selectedMulti.set([]);
                  selected.value = data;
                }
              },
              emptyListWidget: NoDataFound(text: '$title not found', topPadding: 100),
              enableMultiSelect: isMulti,
              sheetTitle: title == null ? null : Text(title!, style: context.text.titleLarge),
              searchFillColor: context.theme.inputDecorationTheme.fillColor ?? context.colors.surfaceContainer,
              listViewSeparatorWidget: const Gap(Insets.med),
              listTileColor: context.colors.surfaceContainer,
              listViewPadding: Pads.sm('lr'),
              listTileContentPadding: Pads.sm('lr'),
              selectedTrailing: Icon(Icons.check_circle, size: 20, color: context.colors.error),
              deSelectedTrailing: Icon(Icons.circle_outlined, size: 20, color: context.colors.onSurface),
              listItemBuilder: (index, item) {
                return itemBuilder?.call(item.data) ?? Text(builder?.call(item.data) ?? uniqueBuilder(item.data));
              },
              searchDelegate: (query, items) {
                String builder(T e) => this.builder?.call(e) ?? e.toString();

                return items
                    .where((e) => searchFn?.call(e.data, query.low) ?? builder(e.data).low.contains(query.low))
                    .toList();
              },
            ),
          );
          await state.showModal(context);
        },
      ),
    );
  }
}
