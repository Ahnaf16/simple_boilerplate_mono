import 'package:collection/collection.dart';
import 'package:resta_dash/main.export.dart';

class Cart extends Model {
  const Cart({required this.id, required this.qty, required this.dish, this.variations = const []});

  final int id;
  final int qty;
  final Dish dish;
  final List<Variation> variations;

  num get total => (qty * (dish.haveDiscount ? dish.discountPrice : dish.price)) + variations.map((e) => e.price).sum;

  factory Cart.fromMap(Map<String, dynamic> map) =>
      Cart(id: map.parseInt('id'), qty: map['qty'], dish: Dish.fromMap(map['dish']));

  static Cart? tryParse(dynamic value) {
    try {
      if (value case final Cart d) return d;
      if (value case final Map map) return Cart.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {'id': id, 'qty': qty, 'dish': dish.toMap()};

  Cart copyWith({int? id, int? qty, Dish? dish, List<Variation>? variations}) {
    return Cart(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      dish: dish ?? this.dish,
      variations: variations ?? this.variations,
    );
  }
}
