import 'package:flutter/material.dart';
import 'package:resta_dash/features/home/controller/main_state_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class DineTypeSheet extends HookConsumerWidget {
  const DineTypeSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainState = ref.watch(mainStateCtrlProvider);
    final mainCtrl = useCallback(() => ref.read(mainStateCtrlProvider.notifier));
    return SizedBox(
      height: context.height * .4,
      child: Padding(
        padding: Pads.med().copyWith(left: Insets.xl, right: Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Where do you want to have your dishes?', style: context.text.bodyLarge),
            const Gap(Insets.lg),
            IntrinsicHeight(
              child: Row(
                spacing: Insets.med,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...DineType.values.map((e) {
                    final selected = mainState.dineType == e;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          mainCtrl().copy((v) => v.copyWith(dineType: () => e));
                          context.nPop();
                        },
                        child: SelectionFrame(
                          selected: selected,
                          child: DecoContainer(
                            borderRadius: Corners.med,
                            padding: Pads.lg(),
                            child: Column(
                              spacing: Insets.sm,
                              children: [
                                if (e == DineType.dineIn)
                                  Assets.raster.dineIn.image(height: 50)
                                else
                                  Assets.raster.takeAway.image(height: 50),
                                Text(e.name.titleCase),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
