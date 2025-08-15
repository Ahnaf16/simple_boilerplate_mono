import 'package:resta_dash/main.export.dart';

class AuthRepo with ApiHandler {
  @override
  DioClient get dio => locate<DioClient>();

  final _sp = locate<SP>();

  bool isLoggedIn() => _sp.accessToken.value != null;

  Future<bool> login(QMap data) async {
    return _setToken('MOCK_TOKEN');
  }

  Future<bool> signUp(QMap data) async {
    return _setToken('MOCK_TOKEN');
  }

  Future<bool> logout() async {
    return _setToken(null);
  }

  Future<bool> _setToken(String? token) async {
    if (token == null) return _sp.accessToken.remove();
    return _sp.accessToken.setValue(token);
  }
}
