import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// Returns `null` and ignores the input.
///
/// Shortcut function to return null and ignore input parameter:
Null identityNull<T>(T a) => null;

class Copier {
  const Copier._();
  static copy(String? text) {
    if (text == null) return;
    Clipboard.setData(ClipboardData(text: text));
    HapticFeedback.mediumImpact();
  }
}

ColorFilter colorFilter(Color color) => ColorFilter.mode(color, BlendMode.srcIn);

Future wait(Function() fn, [double ms = 0]) => Future.delayed(Duration(milliseconds: ms.toInt()), fn);

class InputUtils {
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
  }

  static bool get isMouseConnected => RendererBinding.instance.mouseTracker.mouseIsConnected;

  static void unFocus() {
    primaryFocus?.unfocus();
  }
}

String decodeUri(String uri) => Uri.decodeComponent(uri);
String? tryDecodeUri(dynamic uri) {
  try {
    return decodeUri(uri);
  } catch (e) {
    return null;
  }
}

String encodeUri(String uri) => Uri.encodeComponent(uri);

final decimalRegExp = RegExp(r'^\d*\.?\d*$');
