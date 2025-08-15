import 'package:flutter/widgets.dart';
import 'package:resta_dash/main.export.dart';

enum DineType { dineIn, takeAway }

class MainState {
  const MainState({this.dineType, this.cuisine, this.table});

  final DineType? dineType;
  final Cuisine? cuisine;
  final TableModel? table;

  MainState copyWith({
    ValueGetter<DineType?>? dineType,
    ValueGetter<Cuisine?>? cuisine,
    ValueGetter<TableModel?>? table,
  }) {
    return MainState(
      dineType: dineType != null ? dineType() : this.dineType,
      cuisine: cuisine != null ? cuisine() : this.cuisine,
      table: table != null ? table() : this.table,
    );
  }
}
