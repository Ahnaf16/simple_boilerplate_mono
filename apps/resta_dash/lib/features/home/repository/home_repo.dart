import 'package:collection/collection.dart';
import 'package:resta_dash/main.export.dart';

class HomeRepo with ApiHandler {
  @override
  DioClient get dio => locate<DioClient>();

  final _mockDishes = MockData.dishes.getOrNull();

  Future<Report<HomeData>> getHomeData() {
    return handler<HomeData>(call: () => dio.get(Endpoints.mock), mapper: (r) => MockData.homeData.getOrNull()!);
  }

  FutureReport<List<Dish>> getDishes() async {
    final res = await handler(call: () => dio.get(Endpoints.mock), mapper: (map) => _mockDishes ?? []);
    return res;
  }

  FutureReport<Dish?> getDishDetails(int id) async {
    final res = await handler(
      call: () => dio.get(Endpoints.mock),
      mapper: (map) => _mockDishes?.firstWhereOrNull((e) => e.id == id),
    );
    return res;
  }
}
