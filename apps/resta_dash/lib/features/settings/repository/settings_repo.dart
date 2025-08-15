import 'package:resta_dash/main.export.dart';

class ConfigRepo with ApiHandler {
  @override
  DioClient get dio => locate<DioClient>();

  Future<Report<Config>> getConfig() {
    return handler<Config>(call: () => dio.get(Endpoints.mock), mapper: (r) => MockData.config.getOrNull()!);
  }
}
