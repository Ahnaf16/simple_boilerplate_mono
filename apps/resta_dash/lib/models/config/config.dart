import 'package:resta_dash/main.export.dart';

class Config extends Model {
  const Config({required this.onboarding, required this.tables});
  final List<OnboardingData> onboarding;
  final List<TableModel> tables;

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      onboarding: map.mapList('onboarding', OnboardingData.tryParse).nonNulls.toList(),
      tables: map.mapList('tables', TableModel.tryParse).nonNulls.toList(),
    );
  }

  static Config? tryParse(dynamic value) {
    try {
      if (value case final Config d) return d;
      if (value case final Map map) return Config.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return {'onboarding': onboarding.map((e) => e.toMap()).toList(), 'tables': tables.map((e) => e.toMap()).toList()};
  }
}

class OnboardingData extends Model {
  const OnboardingData({required this.title, required this.description, required this.image});

  final String title;
  final String description;
  final String image;

  factory OnboardingData.fromMap(Map<String, dynamic> map) {
    return OnboardingData(title: map['title'], description: map['description'], image: map['image']);
  }

  static OnboardingData? tryParse(dynamic value) {
    try {
      if (value case final OnboardingData d) return d;
      if (value case final Map map) return OnboardingData.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'image': image};
  }
}
