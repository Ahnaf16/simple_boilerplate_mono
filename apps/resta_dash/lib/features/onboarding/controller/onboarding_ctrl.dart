import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_ctrl.g.dart';

@riverpod
class OnboardingCtrl extends _$OnboardingCtrl {
  final _showOnboard = locate<SP>().showOnboard;

  @override
  bool build() {
    return _showOnboard.value;
  }

  FVoid complete() async {
    state = false;
    await _showOnboard.setValue(false);
    ref.invalidateSelf();
  }
}
