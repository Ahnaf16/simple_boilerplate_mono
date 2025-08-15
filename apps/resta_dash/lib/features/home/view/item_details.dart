import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/features/cart/controller/cart_ctrl.dart';
import 'package:resta_dash/features/home/controller/home_ctrl.dart';
import 'package:resta_dash/features/home/view/local/food_item_tile.dart';
import 'package:resta_dash/main.export.dart';

class ItemDetailsView extends HookConsumerWidget {
  const ItemDetailsView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemData = ref.watch(dishDetailsCtrlProvider(id));
    final carts = ref.watch(cartCtrlProvider).maybeList();
    final cartCtrl = useCallback(() => ref.read(cartCtrlProvider.notifier));

    final loading = useState(false);
    // final loading = useState(false);

    return itemData.when(
      loading: () => Loader.fullScreen(true),
      error: (e, s) => ErrorView(e, s, prov: [dishDetailsCtrlProvider, cartCtrlProvider]).withSF(),
      data: (dish) {
        if (dish == null) return const NoDataFound(text: 'No Item found').withSF();
        final thisCart = carts.firstWhereOrNull((e) => e.dish.id == id);
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: DecoContainer(
            height: 70,
            color: context.colors.surface,
            padding: Pads.med(),
            child: Row(
              children: [
                if (thisCart != null)
                  Expanded(
                    child: _AddCardBtns(loading: loading, cart: thisCart, cartCtrl: cartCtrl),
                  ),
                if (thisCart != null) const Gap(Insets.lg),
                Expanded(
                  flex: 2,
                  child: SubmitButton(
                    onPressed: (l) async {
                      if (l.value) return;
                      if (thisCart != null) return RPaths.cartSummary.push(context);
                      l.truthy();
                      await cartCtrl().addToCart(dish);
                      l.falsey();
                    },

                    child: Text(
                      thisCart != null ? 'Continue' : 'Add to cart',
                      style: context.text.labelLarge?.textColor(context.colors.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: Pads.med().withViewPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HostedImage(dish.imageUrl, width: context.width, height: 180, radius: Corners.lg),
                    const Gap(Insets.med),
                    Text(dish.name, style: context.text.titleMedium?.bold),
                    if (dish.cuisine != null || dish.isPopular) ...[
                      const Gap(Insets.xs),
                      Row(
                        children: [
                          if (dish.cuisine != null) ...[
                            HostedImage(dish.cuisine!.image, width: 20, height: 20, radius: Corners.lg),
                            const Gap(Insets.sm),
                            Text(dish.cuisine?.name.showUntil(30) ?? '', style: context.text.bodySmall),
                            const Gap(Insets.med),
                          ],
                          if (dish.isPopular) ...[
                            Icon(Icons.local_fire_department_outlined, color: context.colors.primary, size: 18),
                            const Gap(Insets.xs),
                            Text('Popular', style: context.text.bodySmall),
                          ],
                        ],
                      ),
                    ],
                    const Gap(Insets.sm),
                    Text(dish.description, style: context.text.bodySmall?.op(.6)),

                    const Gap(Insets.med),
                    Row(
                      spacing: Insets.xs,
                      children: [
                        if (dish.haveDiscount)
                          Text(dish.discountPrice.currency(), style: context.text.titleMedium?.bold),
                        Text(
                          dish.price.currency(),
                          style: dish.haveDiscount
                              ? context.text.bodySmall?.lineThrough.op(.6)
                              : context.text.titleMedium?.bold,
                        ),
                      ],
                    ),

                    if (dish.variations.isNotEmpty) ...[
                      const Gap(Insets.med),
                      UiSection(
                        titleDivider: const Gap(0),
                        titleWidget: Padding(
                          padding: Pads.only(left: Insets.sm - 2),
                          child: Text('Add variations', style: context.text.titleMedium),
                        ),
                        child: Column(
                          spacing: Insets.sm,
                          children: [
                            ...dish.variations.map((e) {
                              final exist = thisCart?.variations.firstWhereOrNull((x) => x.id == e.id);
                              return VariationTile(
                                value: e,
                                isSelected: exist != null,
                                onChanged: (v) async {
                                  if (thisCart == null) return await cartCtrl().addToCart(dish, e);
                                  if (v) {
                                    await cartCtrl().addVariation(thisCart.id, e);
                                  } else {
                                    await cartCtrl().removeVariation(thisCart.id, e);
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],

                    if (dish.boughTogether.isNotEmpty) ...[
                      const Gap(Insets.med),
                      Text('Frequently bought together', style: context.text.titleMedium),
                      const Gap(Insets.sm),
                      ...dish.boughTogether
                          .map((e) {
                            final c = carts.firstWhereOrNull((x) => x.dish.id == e.id);
                            return FoodItemTile(dish: e, cart: c, showDescription: true, direction: Axis.horizontal);
                          })
                          .gapBy(Insets.sm),
                    ],
                    if (dish.note != null) ...[
                      const Gap(Insets.med),
                      Text('Notes', style: context.text.titleMedium),
                      const Gap(Insets.sm),
                      DecoContainer(
                        color: context.colors.surface,
                        borderRadius: Corners.med,
                        padding: Pads.med(),
                        child: Text(dish.note!, style: context.text.bodyMedium?.op(.6)),
                      ),
                    ],
                    const Gap(Insets.offset),
                  ],
                ),
              ),

              //! Back
              Padding(padding: Pads.med().withViewPadding(context), child: const KBackButton()),
            ],
          ),
        );
      },
    );
  }
}

class _AddCardBtns extends StatelessWidget {
  const _AddCardBtns({required this.loading, required this.cart, required this.cartCtrl});

  final ValueNotifier<bool> loading;
  final Cart cart;
  final CartCtrl Function() cartCtrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      spacing: Insets.xs,
      children: [
        GestureDetector(
          onTap: () async {
            if (loading.value) return;

            loading.truthy();
            if (cart.qty == 1) {
              await cartCtrl().removeCart(cart.id);
            } else {
              await cartCtrl().updateQty(cart.id, cart.qty - 1);
            }
            loading.falsey();
          },
          child: DecoContainer(
            color: context.colors.surfaceContainer,
            alignment: Alignment.center,
            borderRadius: Corners.circle,
            height: 30,
            width: 30,
            child: Icon(
              cart.qty == 1 ? Icons.close_rounded : Icons.remove,
              color: context.colors.onSurface.op6,
              size: 18,
            ),
          ),
        ),
        if (loading.value)
          const LoadingIndicator(size: 16)
        else
          Text(cart.qty.compact(), maxLines: 1, textAlign: TextAlign.center, style: context.text.titleMedium),
        GestureDetector(
          onTap: () async {
            if (loading.value) return;
            loading.truthy();
            await cartCtrl().updateQty(cart.id, cart.qty + 1);
            loading.falsey();
          },
          child: DecoContainer(
            color: context.colors.primary,
            alignment: Alignment.center,
            borderRadius: Corners.circle,
            height: 30,
            width: 30,
            child: Icon(Icons.add, color: context.colors.onPrimary, size: 18),
          ),
        ),
      ],
    );
  }
}

class VariationTile extends StatelessWidget {
  const VariationTile({super.key, required this.isSelected, this.onChanged, required this.value});

  final bool isSelected;
  final Variation value;
  final void Function(bool v)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call(!isSelected);
      },
      child: DecoContainer(
        padding: Pads.sm('r'),
        child: Row(
          spacing: Insets.xs,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (v) {
                if (v != null) onChanged?.call(v);
              },
            ),
            Text(value.name),
            const Spacer(),
            Text('+${value.price.currency()}', style: context.text.bodyMedium?.op(.6)),
          ],
        ),
      ),
    );
  }
}
