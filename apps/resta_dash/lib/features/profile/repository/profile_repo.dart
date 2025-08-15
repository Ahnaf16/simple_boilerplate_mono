import 'package:resta_dash/main.export.dart';

class ProfileRepo with ApiHandler {
  @override
  DioClient get dio => locate<DioClient>();

  Future<Report<User>> getUser() {
    return handler<User>(call: () => dio.get(Endpoints.mock), mapper: (r) => MockData.user.getOrNull()!);
  }
}
