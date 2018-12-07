import 'package:flutter/material.dart';
import 'src/app.dart';

// Makes available debugPaintSizeEnabled
import 'package:flutter/rendering.dart';

void main() {
  // Enables visual tools to help with widgets
  debugPaintSizeEnabled = false;

  runApp(App());
}

