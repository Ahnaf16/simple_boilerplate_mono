import 'package:flutter/foundation.dart';
import 'package:resta_dash/main.export.dart';

class Endpoints {
  Endpoints._();

  static EndPoint get mock => const EndPoint('https://jsonplaceholder.typicode.com/todos/1');

  static String? testURL;
  static bool get isTestUrl => testURL != null && !kReleaseMode;

  // base url
  static const String _baseUrl = 'https://api.resta_dash.com';
  static const String _apiSuffix = 'api/user';

  static String get _host => '${isTestUrl ? testURL : _baseUrl}';

  static EndPoint get clientApi => EndPoint('$_host/$_apiSuffix');

  static EndPoint get login => const EndPoint('/login');
  static EndPoint get signUp => const EndPoint('/signup');
  static EndPoint get logout => const EndPoint('/logout');

  static EndPoint get userProfile => const EndPoint('/profile');
}
