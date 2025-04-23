import 'package:flutter/material.dart';

class MyChipTheme {
  MyChipTheme._(); // Prevent instantiation

  /// Light Chip Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withValues(
      alpha: 255 * 0.4,
      red: Colors.grey.r.toDouble(),
      green: Colors.grey.g.toDouble(),
      blue: Colors.grey.b.toDouble(),
    ),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
    backgroundColor: Colors.transparent,
    secondarySelectedColor: Colors.blue.withValues(
      alpha: 255 * 0.2,
      red: Colors.blue.r.toDouble(),
      green: Colors.blue.g.toDouble(),
      blue: Colors.blue.b.toDouble(),
    ),
    brightness: Brightness.light,
  );

  /// Dark Chip Theme
  static final ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
    backgroundColor: Colors.transparent,
    secondarySelectedColor: Colors.blueAccent,
    brightness: Brightness.dark,
  );
}
