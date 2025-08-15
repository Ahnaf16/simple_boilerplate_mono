import 'dart:convert';

import 'package:core_functionality/core_functionality.dart';
import 'package:database/database.dart';

extension DioExceptionEx on DioException {
  bool get isTimeout =>
      type == DioExceptionType.connectionTimeout ||
      type == DioExceptionType.receiveTimeout ||
      type == DioExceptionType.connectionError ||
      type == DioExceptionType.sendTimeout;

  Failure toFailure(StackTrace? stackTrace) {
    final ex = this;
    final st = stackTrace ?? this.stackTrace;

    final path = ex.requestOptions.path;

    final failure = Failure(
      ex.isTimeout ? 'Request Timeout' : ex.message ?? 'Something went wrong',
      error: ex.error,
      stackTrace: st,
      isTimeOut: ex.isTimeout,
      statusCode: ex.response?.statusCode ?? -1,
      event: ex.response?.data['event']?.toString(),
      endpoint: path,
    );

    dynamic res = ex.response?.data;

    try {
      if (res case final String s when !s.startsWith('<!DOCTYPE html>')) res = jsonDecode(s);

      // check if res is [Map] and contains a key 'data' which is [Map<dynamic,dynamic>]
      if (res case {'data': final Map resData}) {
        // check if resData contains a key 'error' and is String
        if (resData case {'error': final String e}) return failure.copyWith(message: e);

        // check if resData contains a key 'message' and is String
        if (resData case {'message': final String e}) {
          return failure.copyWith(message: e);
        }

        // check if resData contains a key 'errors' and is [Map<dynamic,dynamic>]
        if (resData case {'errors': final Map errList}) {
          final Map<String, String> errors = {};
          errList.forEach((k, v) {
            // if the value is a List then convert it to List<String>
            if (v is List) {
              errors[k] = List<String>.from(v.map((e) => '$e').toList()).first;
            } else {
              errors[k] = v.toString();
            }
          });

          return failure.copyWith(errors: errors, message: errors.values.firstOrNull);
        }
      }

      if (res case {'message': final String msg}) {
        return failure.copyWith(message: msg);
      }
    } catch (e, s) {
      return failure.copyWith(message: e.toString(), stackTrace: s);
    }

    return failure;
  }
}
