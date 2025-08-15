import 'package:database/src/dio_client.dart';
import 'package:database/src/endpoint.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';

export 'package:dio/dio.dart';

class DioClient {
  DioClient({this.useEvent = true, required this.baseUrl}) {
    _dio = Dio(_options(baseUrl));
    _dio.interceptors.add(_interceptorsWrapper());
    // _dio.interceptors.add(DioLogger());
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
  }

  final bool useEvent;
  final EndPoint baseUrl;
  late Dio _dio;

  final _cacheOptions = CacheOptions(
    store: HiveCacheStore(null),
    policy: CachePolicy.forceCache,
    hitCacheOnNetworkFailure: true,
    maxStale: const Duration(days: 7),
  );

  BaseOptions _options(EndPoint baseUrl) => BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json'},
  );

  Future<Map<String, String?>> header() async {
    // final sp = locate<SP>();
    // final token = sp.accessToken.value;
    // final lang = sp.language.value;

    // return {HttpHeaders.authorizationHeader: 'Bearer $token', 'api-lang': lang};
    return {};
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio.get(
      url,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final formData = data == null ? null : FormData.fromMap(data, ListFormat.multiCompatible);

      final Response response = await _dio.post(
        url,
        data: formData,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // patch:----------------------------------------------------------------------
  Future<Response> patch(
    String url, {
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    String? baseUrl,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(url, data: data, options: options, cancelToken: cancelToken);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Interceptors :----------------------------------------------------------------------
  InterceptorsWrapper _interceptorsWrapper() => InterceptorsWrapper(
    onRequest: (options, handler) async {
      final headers = await header();
      options.headers.addAll(headers);
      return handler.next(options);
    },
    onResponse: (res, handler) async {
      // final data = res.data;
      // if (data is Map) {
      //   final event = data['event'];
      //   if (useEvent && event is String) EvBus.instance.fireAppStateEv(event);
      // }
      return handler.next(res);
    },
    onError: (err, handler) async {
      // final res = err.response?.data;
      // final data = {};
      // if (res is Map) data.addAll(res);

      // final isAuth =
      //     Parser.toBool(data['is_user_authenticate']) ?? Parser.toBool(data['is_business_authenticate']) ?? true;
      // final event = data['event'];

      // if (useEvent) {
      //   if (!isAuth) EvBus.instance.fireLogoutEv();
      //   if (event != null) EvBus.instance.fireAppStateEv(event);
      // }

      return handler.next(err);
    },
  );
}
