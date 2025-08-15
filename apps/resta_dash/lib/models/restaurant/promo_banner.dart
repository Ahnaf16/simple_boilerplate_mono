import 'package:resta_dash/main.export.dart';

class PromoBanner extends Model {
  const PromoBanner({required this.imageUrl});

  final String imageUrl;

  factory PromoBanner.fromMap(Map<String, dynamic> map) => PromoBanner(imageUrl: map['image_url']);

  static PromoBanner? tryParse(dynamic value) {
    try {
      if (value case final PromoBanner d) return d;
      if (value case final Map map) return PromoBanner.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {'image_url': imageUrl};
}
