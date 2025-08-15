import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/features/cart/controller/cart_ctrl.dart';
import 'package:resta_dash/features/cart/view/table_sheet.dart';
import 'package:resta_dash/features/home/controller/main_state_ctrl.dart';
import 'package:resta_dash/features/home/view/local/food_item_tile.dart';
import 'package:resta_dash/main.export.dart';

class CartSummaryView extends HookConsumerWidget {
  const CartSummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartsData = ref.watch(cartCtrlProvider);
    final mainState = ref.watch(mainStateCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), leading: const KBackButton()),
      body: SingleChildScrollView(
        padding: Pads.body(),
        physics: kScrollPhysics,
        child: cartsData.when(
          loading: () => Loader.fullScreen(true),
          error: (e, s) => ErrorView(e, s, prov: [cartCtrlProvider]),
          data: (carts) {
            return Column(
              spacing: Insets.med,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KTextField(
                  name: 'name',
                  hintText: 'Customer name',
                  prefixFillColor: context.colors.surfaceContainer,
                  prefixIcon: Assets.icon.user.svg(width: 18),
                  suffixIcon: KIconBox(child: Assets.icon.edit.svg(width: 18)),
                ),

                KTextField(
                  hintText: mainState.table?.name ?? 'Select Table',
                  readOnly: true,
                  prefixFillColor: context.colors.surfaceContainer,
                  prefixIcon: Assets.icon.reserve.svg(width: 18),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                  onTap: () {
                    showDialog(context: context, builder: (c) => const TableSheet());
                  },
                ),

                Text('Orders', style: context.text.titleMedium?.bold),
                ListView.separated(
                  itemCount: carts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const Gap(Insets.med),
                  itemBuilder: (context, index) {
                    final cart = carts[index];
                    return FoodItemTile(dish: cart.dish, cart: cart, showDescription: true, direction: Axis.horizontal);
                  },
                ),

                KTextField(
                  hintText: 'Promo code',
                  prefixFillColor: context.colors.surfaceContainer,
                  prefixIcon: Assets.icon.discountCircle.svg(width: 18),
                  suffixIcon: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: CenterRight(
                      child: DecoContainer(
                        margin: Pads.med('lr'),
                        padding: Pads.sym(Insets.med, Insets.sm),
                        color: context.colors.primary,
                        borderRadius: Corners.circle,
                        child: Text('Apply', style: context.text.labelMedium?.textColor(context.colors.onPrimary)),
                      ),
                    ),
                  ),
                ),

                DecoContainer(
                  padding: Pads.med(),
                  borderRadius: Corners.lg,
                  color: context.colors.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: Insets.sm,
                    children: [
                      Text('Payment Summary', style: context.text.titleMedium?.bold),
                      SpacedText(left: 'Subtotal', right: carts.map((e) => e.total).sum.currency()),
                      SpacedText(left: 'Tax', right: 5.currency()),
                      const Divider(height: 0),
                      SpacedText(
                        left: 'Grand Total',
                        right: carts.map((e) => e.total).sum.currency(),
                        style: context.text.bodyLarge,
                      ),
                    ],
                  ),
                ),

                Text('Payment', style: context.text.titleMedium?.bold),
                KTextField(
                  hintText: 'Select Payment Method',
                  prefixFillColor: context.colors.surfaceContainer,
                  prefixIcon: const Icon(Icons.credit_card, size: 18),
                  suffixIcon: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: CenterRight(
                      child: DecoContainer(
                        margin: Pads.med('lr'),
                        padding: Pads.sym(Insets.med, Insets.sm),
                        color: context.colors.primary,
                        borderRadius: Corners.circle,
                        child: Text('Change', style: context.text.labelMedium?.textColor(context.colors.onPrimary)),
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(context: context, builder: (c) => const TableSheet());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
