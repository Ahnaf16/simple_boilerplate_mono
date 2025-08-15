import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_state_ctrl.g.dart';

@Riverpod(keepAlive: true)
class MainStateCtrl extends _$MainStateCtrl {
  @override
  MainState build() {
    return const MainState(/* dineType: DineType.dineIn */);
  }

  MainState copy(MainState Function(MainState c) fn) {
    state = fn(state);
    return state;
  }
}
