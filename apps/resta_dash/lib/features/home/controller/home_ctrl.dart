import 'package:resta_dash/features/home/repository/home_repo.dart';
import 'package:resta_dash/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_ctrl.g.dart';

@riverpod
class HomeDataCtrl extends _$HomeDataCtrl {
  final _repo = locate<HomeRepo>();
  @override
  Stream<HomeData> build() {
    return _repo.getHomeData().asStream().asyncMap((res) => res.fold(failThrow, identity));
  }
}

@riverpod
class DishesCtrl extends _$DishesCtrl {
  final _repo = locate<HomeRepo>();
  @override
  FutureOr<List<Dish>> build() async {
    final res = await _repo.getDishes();
    return res.fold((l) => Toaster.showError(l).andReturn([]), identity);
  }
}

@riverpod
class DishDetailsCtrl extends _$DishDetailsCtrl {
  final _repo = locate<HomeRepo>();
  @override
  FutureOr<Dish?> build(int id) async {
    final res = await _repo.getDishDetails(id);
    return res.fold((l) => Toaster.showError(l).andReturn(null), identity);
  }
}
