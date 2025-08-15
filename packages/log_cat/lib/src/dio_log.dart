import 'dart:developer';
import 'dart:io';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:log_cat/log_cat.dart';

class DioLogger extends Interceptor {
  DioLogger._privateConstructor();
  static final DioLogger _instance = DioLogger._privateConstructor();
  factory DioLogger() => _instance;

  static List<String> blackList = [];
  static List<String> ignoreList = [];

  bool captureRequestCount = !kReleaseMode;
  bool logResponse = true;
  bool requestBody = true;
  bool requestHeader = false;
  bool responseBody = true;

  @override
  void onError(err, handler) {
    final path = err.requestOptions.uri.path;
    if (ignoreList.any((e) => path.contains(e))) return handler.next(err);

    const h = LogHelper(true);

    final bf = StringBuffer();
    bf.writeln(h.start('DioException'));
    bf.writeln(h.kvLine('uri', err.requestOptions.uri));
    bf.writeln(h.kvLine('type', err.type));
    if (err.error != null) bf.writeln(h.kvLine('error', err.error));

    if (err.response != null) {
      bf.writeln(h.kvLine('statusCode', err.response?.statusCode));
      bf.writeln(h.start('Error response'));
      bf.writeln(h.jsonMap(1, err.response?.data));
    }
    bf.writeln(h.end('DioException'));
    logPrint(bf.toString());
    handler.next(err);
  }

  @override
  void onRequest(options, handler) {
    final path = options.uri.toString();
    if (ignoreList.any((e) => path.contains(e))) return handler.next(options);

    const h = LogHelper(false);

    final bf = StringBuffer();
    bf.writeln(h.start('Request'));
    bf.writeln(h.kvLine('uri', options.uri));
    bf.writeln(h.kvLine('method', options.method));
    bf.writeln(h.kvLine('Authorization', options.headers[HttpHeaders.authorizationHeader]));

    if (requestHeader && options.headers.isNotEmpty) {
      bf.writeln(h.start('headers'));
      bf.writeln(h.jsonMap(1, options.headers));
    }
    if (requestBody && options.data != null) {
      bf.writeln(h.start('data'));
      bf.writeln(h.jsonMap(1, options.data));
    }

    bf.writeln(h.end('Request'));

    logPrint(bf.toString());

    handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    final path = response.requestOptions.uri.toString();
    if (ignoreList.any((e) => path.contains(e))) return handler.next(response);

    if (!logResponse) return;
    const h = LogHelper(false);
    final bf = StringBuffer();
    bf.writeln(h.start('Response'));
    bf.writeln(h.kvLine('uri', response.requestOptions.uri));
    bf.writeln(h.kvLine('statusCode', response.statusCode));

    if (blackList.any((e) => path.startsWith(e))) return handler.next(response);

    if (responseBody && response.data != null) {
      bf.writeln(h.start('body'));
      bf.writeln(h.jsonMap(1, response.data));
    }

    bf.writeln(h.end('Response'));
    logPrint(bf.toString());

    handler.next(response);
  }

  void logPrint(o) => log(o.toString());
}
