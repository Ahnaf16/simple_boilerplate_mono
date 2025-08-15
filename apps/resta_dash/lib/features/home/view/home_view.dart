import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/features/cart/controller/cart_ctrl.dart';
import 'package:resta_dash/features/home/controller/home_ctrl.dart';
import 'package:resta_dash/features/home/controller/main_state_ctrl.dart';
import 'package:resta_dash/features/home/view/dishes_list_view.dart';
import 'package:resta_dash/features/home/view/local/banners_card.dart';
import 'package:resta_dash/features/home/view/local/cuisine_card.dart';
import 'package:resta_dash/features/home/view/local/dine_type_sheet.dart';
import 'package:resta_dash/features/home/view/local/home_app_bar.dart';
import 'package:resta_dash/features/profile/controller/profile_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainState = ref.watch(mainStateCtrlProvider);
    final mainCtrl = useCallback(() => ref.read(mainStateCtrlProvider.notifier));
    final userData = ref.watch(userCtrlProvider);
    final homeData = ref.watch(homeDataCtrlProvider);
    final cartsData = ref.watch(cartCtrlProvider);

    useEffect(() {
      wait(() {
        if (mainState.dineType != null) return;
        showModalBottomSheet(
          isScrollControlled: true,
          showDragHandle: true,
          context: context,
          builder: (c) => const DineTypeSheet(),
        );
      }, 2000);
      return null;
    }, const []);

    return userData.when(
      loading: () => Loader.fullScreen(true),
      error: (e, s) => ErrorView(e, s, prov: [userCtrlProvider, homeDataCtrlProvider]).withSF(),
      data: (user) {
        return cartsData.when(
          loading: () => Loader.fullScreen(true),
          error: (e, s) => ErrorView(e, s, prov: [cartCtrlProvider, dishesCtrlProvider]),
          data: (carts) {
            return Scaffold(
              appBar: HomeAppBar(mainState: mainState),
              // floatingActionButton: FloatingActionButton.extended(
              //   onPressed: () {},
              //   icon: const Icon(Icons.room_service_outlined),
              //   label: const Text('Call waiter'),
              //   backgroundColor: context.colors.primary,
              //   foregroundColor: context.colors.onPrimary,
              // ),
              extendBody: true,
              bottomNavigationBar: AnimatedSwitcher(
                duration: 500.ms,
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
                    child: child,
                  );
                },
                child: carts.isEmpty
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () => RPaths.cartSummary.push(context),
                        child: DecoContainer(
                          key: ValueKey<bool>(carts.isNotEmpty),
                          height: 50,
                          color: context.colors.primary,
                          borderRadius: Corners.circle,
                          margin: Pads.med('lrb'),
                          padding: Pads.med(),
                          child: DefaultTextStyle(
                            style: context.text.labelLarge!.textColor(context.colors.onPrimary),
                            child: Row(
                              spacing: Insets.sm,
                              children: [
                                const Text('Process Order'),
                                const Spacer(),
                                Text('${carts.length} items'),
                                Text(carts.map((e) => e.total).sum.currency()),
                                Icon(Icons.arrow_forward_rounded, color: context.colors.onPrimary, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),

              body: SingleChildScrollView(
                padding: Pads.body(),
                child: homeData.when(
                  loading: () => Loader.fullScreen(false),
                  error: (e, s) => ErrorView(e, s, prov: [userCtrlProvider, homeDataCtrlProvider]),
                  data: (homeData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Insets.lg,
                      children: [
                        //! Search
                        KTextField(
                          hintText: 'What are you looking for',
                          prefixIcon: Assets.icon.searchLoupe.svg(width: 24),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(height: 20, width: 1, color: context.colors.outline),
                              DecoContainer(
                                padding: Pads.sm().copyWith(left: Insets.med),
                                child: Assets.icon.filter.svg(width: 18),
                              ),
                            ],
                          ),
                        ),

                        //! Promotional Banner
                        if (homeData.banners.isNotEmpty) BannersSlider(banners: homeData.banners),

                        //! Cuisine
                        // const Gap(0),
                        SizedBox(
                          height: 80,
                          child: ListView.separated(
                            itemCount: homeData.cuisines.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (_, _) => const Gap(Insets.med),
                            itemBuilder: (context, index) {
                              final cuisine = homeData.cuisines[index];
                              final selected = mainState.cuisine?.id == cuisine.id;
                              return CuisineCard(mainCtrl: mainCtrl, selected: selected, cuisine: cuisine);
                            },
                          ),
                        ),

                        //! Popular Dishes
                        if (mainState.cuisine == null) ...[
                          DishesListView(title: 'Popular Items', carts: carts, onlyPopular: true),
                        ],

                        //! All Dishes
                        DishesListView(
                          title: '${mainState.cuisine?.name ?? 'All'} Items',
                          carts: carts,
                          isList: true,
                          cuisine: mainState.cuisine,
                        ),
                        const Gap(Insets.offset),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
