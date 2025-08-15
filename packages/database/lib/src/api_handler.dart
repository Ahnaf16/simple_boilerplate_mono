import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:core_functionality/core_functionality.dart';
import 'package:database/src/dio_client.dart';
import 'package:database/src/dio_error.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

mixin ApiHandler {
  DioClient get dio;

  FutureReport<T> handler<T>({
    required Future<Response> Function() call,
    required T Function(Map<String, dynamic> map) mapper,
  }) async {
    try {
      final Response(:statusCode, :data) = await call();

      if (statusCode == null || statusCode < 200 || statusCode >= 300) {
        return failure('Call ended with code $statusCode', e: data);
      }

      final decoded = _decodeResponse(data);

      if (decoded case final Map<String, dynamic> decode) {
        return right(mapper(decode));
      }

      return failure('Expected Map<String,dynamic>, got ${decoded.runtimeType}', e: data);
    } on SocketException catch (e, st) {
      return failure(e.message, e: e, s: st);
    } on DioException catch (e, st) {
      final failure = e.toFailure(st);
      return left(failure);
    } on Failure catch (e, st) {
      return left(e.copyWith(stackTrace: st));
    } catch (e, st) {
      return failure('$e', e: e, s: st);
    }
  }

  Stream<Report<T>> handlerWithCache<T>({
    required String cacheKey,
    required Box<T> box,
    required Future<Response> Function() call,
    required T Function(Map<String, dynamic> map) mapper,
    bool refresh = false,
  }) async* {
    try {
      // final cached = box.get(cacheKey);

      // cat(cached == null ? 'No cache for $cacheKey' : 'Cache type: <${cached.runtimeType}> on $cacheKey', 'Hive');

      // if (cached != null && !refresh) yield right(cached);

      final res = await handler<T>(call: call, mapper: mapper);

      yield await res.fold(
        (err) async {
          // if (cached != null) {
          //   catErr('Returning cached on error ($cacheKey)', err.error, err.stackTrace);
          //   return right(cached);
          // }
          return left(err);
        },
        (data) async {
          // unawaited(box.put(cacheKey, data));
          // cat('Set cache type: ${data.runtimeType}', 'Hive $cacheKey');
          return right(data);
        },
      );
    } on HiveError catch (e, st) {
      yield failure(e.message, e: e, s: st);
    } catch (e, st) {
      yield failure('$e', e: e, s: st);
    }
  }

  Map<String, dynamic>? _decodeResponse(dynamic data) {
    try {
      if (data case final Map decode) return decode.toStringKey();

      if (data case final String decode) {
        final decoded = jsonDecode(decode);
        if (decoded case final Map d) return d.toStringKey();
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
