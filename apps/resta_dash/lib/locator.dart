import 'package:database/src/dio_client.dart';
import 'package:get_it/get_it.dart';
import 'package:resta_dash/features/auth/repository/auth_repo.dart';
import 'package:resta_dash/features/cart/repository/cart_repo.dart';
import 'package:resta_dash/features/home/repository/home_repo.dart';
import 'package:resta_dash/features/profile/repository/profile_repo.dart';
import 'package:resta_dash/features/settings/repository/settings_repo.dart';

import 'main.export.dart';

extension GetItEX on GetIt {
  void registerLazyIfAbsent<T extends Object>(T Function() factoryFunc) {
    if (!isRegistered<T>()) registerLazySingleton(factoryFunc);
  }

  void registerLazyAsyncIfAbsent<T extends Object>(Future<T> Function() f) {
    if (!isRegistered<T>()) registerLazySingletonAsync(f);
  }
}

final locate = GetIt.instance;

Future<void> initDependencies() async {
  final sp = await SP.getInstance();

  locate.registerSingletonIfAbsent<SP>(() => sp);

  locate.registerSingletonIfAbsent<DioClient>(() => DioClient(baseUrl: Endpoints.clientApi));
  locate.registerSingletonIfAbsent<ConfigRepo>(() => ConfigRepo());
  locate.registerSingletonIfAbsent<AuthRepo>(() => AuthRepo());
  locate.registerSingletonIfAbsent<HomeRepo>(() => HomeRepo());
  locate.registerSingletonIfAbsent<ProfileRepo>(() => ProfileRepo());
  locate.registerSingletonIfAbsent<CartRepo>(() => CartRepo());
}
