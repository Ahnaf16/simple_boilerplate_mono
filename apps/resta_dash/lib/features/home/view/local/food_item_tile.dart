import 'package:flutter/material.dart';
import 'package:resta_dash/features/cart/controller/cart_ctrl.dart';
import 'package:resta_dash/features/home/view/local/cart_add_widget.dart';
import 'package:resta_dash/main.export.dart';

class FoodItemTile extends HookConsumerWidget {
  const FoodItemTile({
    super.key,
    required this.dish,
    this.cart,
    this.direction = Axis.vertical,
    this.showDescription = false,
  });

  final Dish dish;
  final Cart? cart;
  final Axis direction;
  final bool showDescription;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debouncer = useMemoized(() => Debouncer(delay: 2.seconds));
    final cartCtrl = useCallback(() => ref.read(cartCtrlProvider.notifier));

    final isHo = direction == Axis.horizontal;

    return GestureDetector(
      onTap: () => RPaths.itemDetails(dish.id).push(context),
      child: DecoContainer(
        color: context.colors.surface,
        borderRadius: Corners.lg,
        padding: Pads.sm(),
        clipChild: true,
        child: Flex(
          direction: direction,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Corners.medBorder,
              child: Stack(
                children: [
                  DecoContainer(
                    height: isHo ? 80 : 120,
                    width: isHo ? 80 : double.infinity,
                    color: context.colors.surfaceContainerHighest,
                    child: HostedImage(dish.imageUrl),
                  ),
                  if (!isHo) Positioned(bottom: 5, right: 5, child: cartAddWidget(debouncer, cartCtrl)),
                ],
              ),
            ),
            const Gap(Insets.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dish.name, style: context.text.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                if (showDescription && dish.shortDescription != null)
                  Text(
                    dish.shortDescription!,
                    style: context.text.bodySmall?.textColor(context.colors.onSurface.op6),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const Gap(Insets.sm),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        spacing: Insets.xs,
                        children: [
                          if (dish.haveDiscount)
                            Text(dish.discountPrice.currency(), style: context.text.bodyMedium!.bold),
                          Text(
                            dish.price.currency(),
                            style: dish.haveDiscount
                                ? context.text.labelSmall?.lineThrough.op(.4)
                                : context.text.bodyMedium!.bold,
                          ),
                        ],
                      ),
                    ),
                    if (isHo) cartAddWidget(debouncer, cartCtrl),
                  ],
                ),
              ],
            ).conditionalExpanded(isHo),
          ],
        ),
      ),
    );
  }

  CartAddWidget cartAddWidget(Debouncer debouncer, CartCtrl Function() cartCtrl) {
    return CartAddWidget(
      initialQuantity: cart?.qty ?? 0,
      onAdd: (v) {
        if (cart == null) {
          debouncer.run(() => cartCtrl().addToCart(dish));
        } else {
          debouncer.run(() => cartCtrl().updateQty(cart!.id, v));
        }
      },
      onRemove: (v) {
        if (cart != null) debouncer.run(() => cartCtrl().updateQty(cart!.id, v));
      },
      onDelete: () {
        debouncer.cancel();
        if (cart != null) cartCtrl().removeCart(cart!.id);
      },
    );
  }
}
