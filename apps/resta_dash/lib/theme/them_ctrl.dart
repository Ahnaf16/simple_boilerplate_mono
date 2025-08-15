// import 'package:flutter/material.dart';
// import 'package:resta_dash/main.export.dart';

// final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

// class ThemeNotifier extends Notifier<ThemeMode> {
//   final _sp = locate<SP>();

//   void setMode(ThemeMode mode) {
//     state = mode;
//     _sp.isLight.setValue(mode == ThemeMode.light);
//   }

//   ThemeMode _effectiveMode(bool? isLight) => switch (isLight) {
//     true => ThemeMode.light,
//     false => ThemeMode.dark,
//     null => ThemeMode.system,
//   };

//   @override
//   ThemeMode build() {
//     final mode = _effectiveMode(_sp.isLight.value);

//     return mode;
//   }
// }
