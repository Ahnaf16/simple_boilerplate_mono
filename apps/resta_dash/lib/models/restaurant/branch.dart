import 'package:resta_dash/main.export.dart';

class Branch extends Model {
  const Branch({required this.name, required this.image, required this.available, required this.address});

  final String name;
  final String image;
  final bool available;
  final String address;

  @override
  Map<String, dynamic> toMap() {
    return {'name': name, 'image': image, 'available': available, 'address': address};
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(name: map['name'], image: map['image'], available: map['available'], address: map['address']);
  }

  static Branch? tryParse(dynamic value) {
    try {
      if (value case final Branch b) return b;
      if (value case final Map map) return Branch.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }
}
