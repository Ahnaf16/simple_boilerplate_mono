import 'package:flutter/material.dart';
import 'package:resta_dash/features/home/controller/main_state_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class CuisineCard extends StatelessWidget {
  const CuisineCard({super.key, required this.mainCtrl, required this.selected, required this.cuisine});

  final MainStateCtrl Function() mainCtrl;
  final bool selected;
  final Cuisine cuisine;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mainCtrl().copy((c) => c.copyWith(cuisine: () => selected ? null : cuisine));
      },
      child: SizedBox(
        width: 64,
        child: Column(
          children: [
            DecoContainer.animated(
              duration: 300.ms,
              color: selected ? context.colors.primary.op1 : context.colors.surface,
              borderColor: context.colors.primary,
              borderWidth: selected ? 1 : 0,
              borderRadius: Corners.lg,
              height: 60,
              width: 64,
              alignment: Alignment.center,
              child: HostedImage.square(cuisine.image, dimension: 36, radius: Corners.med),
            ),
            const Gap(Insets.xs),
            Text(
              cuisine.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: context.text.bodySmall?.textColor(selected ? context.colors.primary : null).op(selected ? 1 : .6),
            ),
          ],
        ),
      ),
    );
  }
}
