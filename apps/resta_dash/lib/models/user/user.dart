import 'package:resta_dash/main.export.dart';

class User extends Model {
  const User({required this.id, required this.name, required this.email, required this.photo});

  final int id;
  final String name;
  final String email;
  final String photo;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], email: map['email'], photo: map['photo']);
  }

  static User? tryParse(dynamic value) {
    try {
      if (value case final User u) return u;
      if (value case final Map map) return User.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'photo': photo};
  }
}
