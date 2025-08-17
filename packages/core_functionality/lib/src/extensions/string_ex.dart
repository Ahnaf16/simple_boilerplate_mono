import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringEx on String {
  int get asInt => isEmpty ? 0 : int.tryParse(this) ?? 0;

  double get asDouble => double.tryParse(this) ?? 0.0;

  String showUntil(int end, [int start = 0]) {
    return length >= end ? '${substring(start, end)}...' : this;
  }

  String ifEmpty([String onEmpty = 'EMPTY']) {
    return isEmpty ? onEmpty : this;
  }

  /// Gracefully handles null values, and skips the suffix when null
  String safeGet([String? suffix]) {
    return this + (isNotEmpty ? (suffix ?? '') : '');
  }

  bool get isValidEmail {
    final reg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return reg.hasMatch(this);
  }

  String get low => toLowerCase();
  String get up => toUpperCase();
}

extension ValueEx on ValueNotifier<bool> {
  void toggle() => value = !value;
  void truthy() => value = true;
  void falsey() => value = false;
}

extension ValueTEx<T> on ValueNotifier<T> {
  void set(T value) => this.value = value;
}

extension ListValueTEx<T> on ValueNotifier<List<T>> {
  void add(T value) => this.value = List.from(this.value)..add(value);
  void addAll(Iterable<T> values) => value = List.from(value)..addAll(values);
  void remove(T value) => this.value = List.from(this.value)..remove(value);
  void removeWhere(bool Function(T) test) => value = List.from(value)..removeWhere(test);
  void removeAll(Iterable<T> values) => value = List.from(value)..removeWhere(values.contains);
  void clear() => value = [];
}

extension NumEx on num {
  String readableByte([int? decimals]) => Parser.formatBytes(toInt(), decimals ?? 2);

  String twoDigits([String padWith = '0']) => toString().padLeft(2, padWith);

  String currency([bool compact = false]) {
    if (compact) return NumberFormat.compactCurrency(symbol: '\$').format(this);

    final formatter = NumberFormat.currency(symbol: '\$', locale: 'en_US');
    return formatter.format(this);
  }

  String compact() {
    final formatter = NumberFormat.compact();
    return formatter.format(this);
  }
}
