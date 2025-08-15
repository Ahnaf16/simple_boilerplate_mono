// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_pref.dart';

// **************************************************************************
// SharedPreferencesGenerator
// **************************************************************************

extension $SharedPreferencesGenX on SharedPreferences {
  Set<$SharedPrefValueGen> get entries => {accessToken, language, showOnboard};

  $SharedPrefValue<String> get accessToken {
    return $SharedPrefValue<String>(
      key: 'accessToken',
      getter: getString,
      setter: setString,
      remover: remove,
    );
  }

  $SharedPrefValue<String> get language {
    return $SharedPrefValue<String>(
      key: 'language',
      getter: getString,
      setter: setString,
      remover: remove,
    );
  }

  $SharedPrefValueWithDefault<bool> get showOnboard {
    return $SharedPrefValueWithDefault<bool>(
      key: 'showOnboard',
      getter: getBool,
      setter: setBool,
      remover: remove,
      defaultValue: true,
    );
  }
}
