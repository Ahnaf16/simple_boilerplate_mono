import 'package:resta_dash/features/settings/repository/settings_repo.dart';
import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_ctrl.g.dart';

@Riverpod(keepAlive: true)
class ConfigCtrl extends _$ConfigCtrl {
  final _repo = locate<ConfigRepo>();

  @override
  FutureOr<Config> build() async {
    final res = await _repo.getConfig();
    return res.fold(failThrow, identity);
  }
}
