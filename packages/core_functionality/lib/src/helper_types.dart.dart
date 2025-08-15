import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

typedef FromMapT<T> = T Function(QMap map);
typedef ToMapT<T> = Map Function(T data);

typedef ResponseCallBack = Future<Response> Function();

typedef QMap = Map<String, dynamic>;
typedef SMap = Map<String, String>;

typedef FormBuilderTextState = FormBuilderFieldState<FormBuilderField<String>, String>;

typedef FVoid = Future<void>;
typedef FutureCallback<T> = Future<T> Function();
typedef FutureVCallback<T> = Future<T> Function(T value);
typedef FutureVoidCallback = Future<void> Function();
typedef StSub<T> = StreamSubscription<T>;
