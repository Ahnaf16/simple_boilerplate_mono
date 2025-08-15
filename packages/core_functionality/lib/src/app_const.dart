import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Default scroll physics for scrollable widgets
const kScrollPhysics = AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());

const kName = 'Resta Dash';

String kError([String? errorOn]) {
  String err = 'Something went wrong';
  if (kDebugMode) err += ' [$errorOn]';
  return err;
}
