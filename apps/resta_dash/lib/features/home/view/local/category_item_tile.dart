import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class CategoryItemTile extends StatelessWidget {
  final Cuisine category;

  const CategoryItemTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: DecoContainer(
        height: 100,
        width: 100,
        color: context.colors.surface,
        borderRadius: Corners.med,
        padding: Pads.sm(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(borderRadius: Corners.medBorder, child: HostedImage(category.image, height: 50, width: 50)),
            const Gap(Insets.xs),
            Text(category.name, maxLines: 1, style: context.text.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
