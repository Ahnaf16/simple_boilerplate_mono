import 'package:resta_dash/features/profile/repository/profile_repo.dart';
import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_ctrl.g.dart';

@riverpod
class UserCtrl extends _$UserCtrl {
  final _repo = locate<ProfileRepo>();

  @override
  Stream<User> build() {
    return _repo.getUser().asStream().asyncMap((res) => res.fold(failThrow, identity));
  }
}
