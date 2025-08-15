import 'package:resta_dash/main.export.dart';

class Cuisine extends Model {
  const Cuisine({required this.name, required this.image, required this.id});

  final int id;
  final String name;
  final String image;

  factory Cuisine.fromMap(Map<String, dynamic> map) => Cuisine(name: map['name'], image: map['image'], id: map['id']);

  static Cuisine? tryParse(dynamic value) {
    try {
      if (value case final Cuisine d) return d;
      if (value case final Map map) return Cuisine.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {'name': name, 'image': image, 'id': id};
}
