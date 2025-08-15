import 'package:collection/collection.dart';
import 'package:resta_dash/features/cart/repository/cart_repo.dart';
import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_ctrl.g.dart';

@Riverpod(keepAlive: true)
class CartCtrl extends _$CartCtrl {
  final _repo = locate<CartRepo>();
  @override
  FutureOr<List<Cart>> build() async {
    return [];
    // final res = await _repo.getCart();

    // return res.fold((l) => Toaster.showError(l).andReturn([]), identity);
  }

  FVoid addToCart(Dish dish, [Variation? v]) async {
    final current = await future;
    final newId = current.length + 1;
    final cart = Cart(id: newId, qty: 1, dish: dish, variations: [?v]);
    state = AsyncData([...current, cart]);

    await _repo.addToCart({});
  }

  FVoid updateQty(int id, int qty) async {
    final current = (await future).toList();

    if (qty == 0) return await removeCart(id);

    state = AsyncData(current.map((e) => e.id == id ? e.copyWith(qty: qty) : e).toList());

    await _repo.updateQty({});
  }

  FVoid addVariation(int id, Variation v) async {
    final current = (await future).toList();

    state = AsyncData(current.map((e) => e.id == id ? e.copyWith(variations: [...e.variations, v]) : e).toList());
  }

  FVoid removeVariation(int id, Variation v) async {
    final current = (await future).toList();

    state = AsyncData(
      current
          .map((e) => e.id == id ? e.copyWith(variations: e.variations.whereNot((e) => e.id == v.id).toList()) : e)
          .toList(),
    );
  }

  FVoid removeCart(int id) async {
    final current = (await future).toList();

    state = AsyncData(current.whereNot((e) => e.id == id).toList());
    await _repo.deleteCart(id);
  }
}
