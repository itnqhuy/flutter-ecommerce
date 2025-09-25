import 'package:flutter/material.dart';

class MyChipTheme {
  MyChipTheme._(); // Prevent instantiation

  /// Light Chip Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
    backgroundColor: Colors.transparent,
    secondarySelectedColor: Colors.blue.withOpacity(0.2),
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
