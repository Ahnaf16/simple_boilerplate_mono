import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/features/home/controller/main_state_ctrl.dart';
import 'package:resta_dash/features/settings/controller/settings_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class TableSheet extends HookConsumerWidget {
  const TableSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configData = ref.watch(configCtrlProvider);
    final mainState = ref.watch(mainStateCtrlProvider);
    final mainCtrl = useCallback(() => ref.read(mainStateCtrlProvider.notifier));
    return configData.when(
      loading: () => Loader.fullScreen(true),
      error: (e, s) => ErrorView(e, s, prov: [configCtrlProvider]).withSF(),
      data: (config) {
        final tableLayout = config.tables.groupListsBy((e) => e.position);
        return Scaffold(
          backgroundColor: context.colors.surfaceContainer,
          appBar: AppBar(title: const Text('Select Table'), leading: const KBackButton()),
          body: Padding(
            padding: Pads.body(),
            child: Center(
              child: Column(
                spacing: Insets.lg,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var entry in tableLayout.entries)
                    Row(
                      spacing: Insets.lg,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var table in entry.value)
                          TableCard(
                            table: table,
                            selected: mainState.table?.id == table.id,
                            onSelected: (t) {
                              if (t.isAvailable) {
                                if (mainState.table?.id == table.id) {
                                  mainCtrl().copy((v) => v.copyWith(table: () => null));
                                  return;
                                }
                                mainCtrl().copy((v) => v.copyWith(table: () => t));
                                context.nPop();
                              }
                            },
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TableCard extends StatelessWidget {
  const TableCard({super.key, required this.table, this.selected = false, this.onSelected});
  final TableModel table;
  final bool selected;
  final Function(TableModel table)? onSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected?.call(table),
      child: Column(
        spacing: Insets.med,
        children: [
          Row(
            spacing: Insets.sm,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < table.size.capacity / 2; i++)
                DecoContainer(
                  height: 10,
                  width: 30,
                  borderRadius: Corners.circle,
                  color: selected ? context.colors.secondary : context.colors.surface,
                ),
            ],
          ),
          Stack(
            children: [
              DecoContainer(
                height: 60,
                width: table.size.width,
                color: selected ? context.colors.secondary : context.colors.surface,
                borderRadius: table.size.radius,
                alignment: Alignment.center,
                child: DecoContainer(
                  height: 20,
                  width: 20,
                  color: selected
                      ? context.colors.surface
                      : (table.isAvailable ? AppTheme.secondary : context.colors.error),
                  borderRadius: Corners.lg,
                  padding: Pads.lg(''),
                  alignment: Alignment.center,
                  child: Text(
                    table.size.capacity.toString(),
                    style: context.text.bodyMedium?.textColor(
                      selected ? context.colors.onSurface : context.colors.onPrimary,
                    ),
                  ),
                ),
              ),
              if (selected)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(Icons.check_circle_rounded, color: context.colors.onPrimary, size: 20),
                ),
            ],
          ),
          Row(
            spacing: Insets.sm,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < table.size.capacity / 2; i++)
                DecoContainer(
                  height: 10,
                  width: 30,
                  borderRadius: Corners.circle,
                  color: selected ? context.colors.secondary : context.colors.surface,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
