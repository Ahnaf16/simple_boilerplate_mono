import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resta_dash/features/cart/controller/cart_ctrl.dart';
import 'package:resta_dash/features/home/controller/home_ctrl.dart';
import 'package:resta_dash/features/home/view/local/food_item_tile.dart';
import 'package:resta_dash/main.export.dart';

class DishesListView extends ConsumerWidget {
  const DishesListView({
    super.key,
    required this.title,
    this.carts = const [],
    this.onlyPopular = false,
    this.isList = false,
    this.cuisine,
  });

  final List<Cart> carts;
  final bool onlyPopular;
  final bool isList;
  final Cuisine? cuisine;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishesData = ref.watch(dishesCtrlProvider);
    return dishesData.when(
      loading: () => Loader.fullScreen(false),
      error: (e, s) => ErrorView(e, s, prov: [dishesCtrlProvider, cartCtrlProvider]),
      data: (dishes) {
        if (onlyPopular) {
          dishes = dishes.where((e) => e.isPopular).takeFirst(4).toList();
        }

        if (isList) {
          if (cuisine != null) dishes = dishes.where((e) => e.cuisine?.id == cuisine?.id).toList();
          if (dishes.isEmpty) return NoDishFound(cuisine: cuisine);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Insets.lg,
            children: [
              Text(' $title', style: context.text.bodyLarge?.semiBold),
              ListView.separated(
                itemCount: dishes.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, __) => const Gap(Insets.med),
                itemBuilder: (context, index) {
                  final dish = dishes[index];
                  final cart = carts.firstWhereOrNull((e) => e.dish.id == dish.id);
                  return FoodItemTile(dish: dish, cart: cart, showDescription: true, direction: Axis.horizontal);
                },
              ),
            ],
          );
        }

        if (dishes.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Insets.lg,
          children: [
            Text(' $title', style: context.text.bodyLarge?.semiBold),
            StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: Insets.med,
              mainAxisSpacing: Insets.med,
              children: List.generate(dishes.length, (index) {
                final fullWidth = (index == dishes.length - 1) && dishes.length.isOdd;
                final span = fullWidth ? 2 : 1;

                final dish = dishes[index];
                final cart = carts.firstWhereOrNull((e) => e.dish.id == dish.id);

                return StaggeredGridTile.fit(
                  crossAxisCellCount: span,
                  child: FoodItemTile(
                    dish: dish,
                    cart: cart,
                    showDescription: fullWidth,
                    direction: fullWidth ? Axis.horizontal : Axis.vertical,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}

class NoDishFound extends StatelessWidget {
  const NoDishFound({super.key, required this.cuisine});

  final Cuisine? cuisine;

  @override
  Widget build(BuildContext context) {
    return DecoContainer(
      alignment: Alignment.center,
      padding: Pads.lg(),
      borderRadius: Corners.med,
      borderColor: context.colors.onSurface.op6,
      borderWidth: 1,
      child: Column(
        children: [
          Icon(Icons.remove_circle_outline_rounded, color: context.colors.onSurface.op6, size: 25),
          const Gap(Insets.med),
          Text(
            'No dishes found${cuisine != null ? ' for ${cuisine?.name}' : ''}',
            style: context.text.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
