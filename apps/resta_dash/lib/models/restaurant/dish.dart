import 'package:flutter/widgets.dart';
import 'package:resta_dash/main.export.dart';

class Dish extends Model {
  const Dish({
    required this.id,
    required this.name,
    required this.description,
    this.shortDescription,
    required this.note,
    required this.price,
    required this.discountPrice,
    required this.haveDiscount,
    required this.imageUrl,
    this.cuisine,
    this.isPopular = false,
    this.boughTogether = const [],
    this.variations = const [],
  });

  final int id;
  final String name;
  final String? shortDescription;
  final String description;
  final String? note;
  final num price;
  final num discountPrice;
  final bool haveDiscount;
  final String imageUrl;
  final Cuisine? cuisine;
  final bool isPopular;
  final List<Dish> boughTogether;
  final List<Variation> variations;

  factory Dish.fromMap(Map<String, dynamic> map) => Dish(
    id: map.parseInt('id'),
    name: map['name'],
    description: map['description'],
    shortDescription: map['short_description'],
    note: map['note'],
    price: map.parseNum('price'),
    discountPrice: map.parseNum('discount_price'),
    haveDiscount: map.parseBool('have_discount'),
    imageUrl: map['image_url'],
    cuisine: Cuisine.tryParse(map['cuisine']),
    isPopular: map.parseBool('is_popular'),
    boughTogether: map.mapList('bough_together', (e) => Dish.tryParse(e)).nonNulls.toList(),
    variations: map.mapList('variations', (e) => Variation.tryParse(e)).nonNulls.toList(),
  );

  static Dish? tryParse(dynamic value) {
    try {
      if (value case final Dish d) return d;
      if (value case final Map map) return Dish.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'short_description': shortDescription,
    'note': note,
    'price': price,
    'discount_price': discountPrice,
    'have_discount': haveDiscount,
    'image_url': imageUrl,
    'cuisine': cuisine?.toMap(),
    'is_popular': isPopular,
    'bough_together': boughTogether.map((e) => e.toMap()).toList(),
    'variations': variations.map((e) => e.toMap()).toList(),
  };

  Dish copyWith({
    int? id,
    String? name,
    ValueGetter<String?>? shortDescription,
    String? description,
    ValueGetter<String?>? note,
    num? price,
    num? discountPrice,
    bool? haveDiscount,
    String? imageUrl,
    ValueGetter<Cuisine?>? cuisine,
    bool? isPopular,
    List<Dish>? boughTogether,
    List<Variation>? variations,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription != null ? shortDescription() : this.shortDescription,
      description: description ?? this.description,
      note: note != null ? note() : this.note,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      haveDiscount: haveDiscount ?? this.haveDiscount,
      imageUrl: imageUrl ?? this.imageUrl,
      cuisine: cuisine != null ? cuisine() : this.cuisine,
      isPopular: isPopular ?? this.isPopular,
      boughTogether: boughTogether ?? this.boughTogether,
      variations: variations ?? this.variations,
    );
  }
}

class Variation extends Model {
  const Variation({required this.id, required this.name, required this.price});

  final int id;
  final String name;
  final num price;

  factory Variation.fromMap(Map<String, dynamic> map) =>
      Variation(id: map.parseInt('id'), name: map['name'], price: map.parseNum('price'));

  static Variation? tryParse(dynamic value) {
    try {
      if (value case final Variation d) return d;
      if (value case final Map map) return Variation.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'price': price};
}
