import 'package:resta_dash/features/auth/repository/auth_repo.dart';
import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_ctrl.g.dart';

@Riverpod(keepAlive: true)
class AuthCtrl extends _$AuthCtrl {
  final _repo = locate<AuthRepo>();

  @override
  bool build() {
    return _repo.isLoggedIn();
  }

  Future<bool> login(QMap data) async {
    await Future.delayed(2.seconds);
    await _repo.login(data);
    ref.invalidateSelf();
    return state;
  }

  Future<bool> signUp(QMap data) async {
    await Future.delayed(2.seconds);
    await _repo.signUp(data);
    ref.invalidateSelf();
    return state;
  }

  Future<bool> logout() async {
    await Future.delayed(2.seconds);
    await _repo.logout();
    ref.invalidateSelf();
    return state;
  }
}
