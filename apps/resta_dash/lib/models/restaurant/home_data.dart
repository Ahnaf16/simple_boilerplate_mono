import 'package:resta_dash/main.export.dart';

class HomeData extends Model {
  const HomeData({required this.cuisines, required this.banners, required this.popularDishes});

  final List<Cuisine> cuisines;
  final List<PromoBanner> banners;
  final List<Dish> popularDishes;

  factory HomeData.fromMap(Map<String, dynamic> map) => HomeData(
    cuisines: map.mapList('cuisine', (x) => Cuisine.fromMap(x)),
    banners: map.mapList('banners', PromoBanner.fromMap),
    popularDishes: map.mapList('popular_dishes', (x) => Dish.fromMap(x)),
  );

  static HomeData? tryParse(dynamic value) {
    try {
      if (value case final HomeData d) return d;
      if (value case final Map map) return HomeData.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {
    'categories': cuisines.map((x) => x.toMap()).toList(),
    'daily_special': banners.map((x) => x.toMap()).toList(),
    'popular_dishes': popularDishes.map((x) => x.toMap()).toList(),
  };
}
