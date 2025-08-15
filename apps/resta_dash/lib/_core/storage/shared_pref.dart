import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_annotation/shared_preferences_annotation.dart';

part 'shared_pref.g.dart';

/// Short hand for [SharedPreferences]
typedef SP = SharedPreferences;

@SharedPrefData(
  entries: [
    SharedPrefEntry<String>(key: 'accessToken'),
    SharedPrefEntry<String>(key: 'language'),
    SharedPrefEntry<bool>(key: 'showOnboard', defaultValue: true),
  ],
)
sPDb() {}
