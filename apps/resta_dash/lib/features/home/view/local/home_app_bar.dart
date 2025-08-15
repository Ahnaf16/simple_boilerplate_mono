import 'package:flutter/material.dart';
import 'package:resta_dash/features/home/view/local/dine_type_sheet.dart';
import 'package:resta_dash/main.export.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.mainState});

  final MainState mainState;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // centerTitle: false,
      leading: GestureDetector(
        onTap: () => RPaths.settings.push(context),
        child: Center(child: Assets.icon.menu.svg(width: 35, height: 35)),
      ),

      title: const AppLogo(showName: true, size: 20),
      titleTextStyle: context.text.bodyLarge,
      actions: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              showDragHandle: true,
              context: context,
              builder: (c) => const DineTypeSheet(),
            );
          },
          child: Row(
            spacing: Insets.xs,
            children: [
              Text(mainState.dineType?.name.sentenceCase ?? 'Dine type', style: context.text.bodySmall),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
            ],
          ),
        ),
        const Gap(Insets.sm),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
// class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const HomeAppBar({super.key, required this.mainState, required this.user});

//   final MainState mainState;
//   final User user;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: context.colors.surfaceContainer,
//       titleTextStyle: context.text.bodyLarge,
//       automaticallyImplyLeading: false,
//       toolbarHeight: 90,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const AppLogo(showName: true, size: 20),
//           const Gap(Insets.sm),
//           if (mainState.branch != null) ...[
//             Text(mainState.branch!.name, style: context.text.bodyMedium!.op(.6)),
//             Row(
//               spacing: Insets.xs,
//               children: [
//                 Icon(Icons.location_on_rounded, color: context.colors.outline, size: 12),
//                 Text(mainState.branch!.address, style: context.text.bodySmall!.op(.6)),
//               ],
//             ),
//           ],
//         ],
//       ),
//       actions: [
//         GestureDetector(onTap: () => RPaths.settings.push(context), child: CircleImage(user.photo, radius: 16)),
//         const Gap(Insets.med),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(90);
// }
