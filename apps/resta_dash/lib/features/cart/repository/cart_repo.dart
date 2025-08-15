import 'package:resta_dash/main.export.dart';

class CartRepo with ApiHandler {
  @override
  DioClient get dio => locate<DioClient>();

  FutureReport<List<Cart>> getCart() async {
    final res = await handler(call: () => dio.get(Endpoints.mock), mapper: (map) => <Cart>[]);
    return res;
  }

  FutureReport<Unit> addToCart(QMap data) async {
    final res = await handler(call: () => dio.post(Endpoints.mock), mapper: (map) => unit);

    return res;
  }

  FutureReport<Unit> updateQty(QMap data) async {
    final res = await handler(call: () => dio.post(Endpoints.mock), mapper: (map) => unit);

    return res;
  }

  FutureReport<Unit> deleteCart(int id) async {
    final res = await handler(call: () => dio.get(Endpoints.mock), mapper: (map) => unit);

    return res;
  }
}
