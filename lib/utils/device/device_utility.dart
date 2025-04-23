import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:url_launcher/url_launcher_string.dart';

class MyDeviceUtils {
  MyDeviceUtils._();

  /// Hide the soft keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Set status bar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  /// Is landscape orientation
  static bool isLandscape(BuildContext context) =>
      View.of(context).viewInsets.bottom == 0;

  /// Is portrait orientation
  static bool isPortrait(BuildContext context) =>
      View.of(context).viewInsets.bottom != 0;

  /// Set full screen mode
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
      enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  /// Get screen height
  static double getScreenHeight() => MediaQuery.of(Get.context!).size.height;

  /// Get screen width
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Get device pixel ratio
  static double getPixelRatio() => MediaQuery.of(Get.context!).devicePixelRatio;

  /// Get status bar height
  static double getStatusBarHeight() => MediaQuery.of(Get.context!).padding.top;

  /// Get app bar height (default)
  static double getAppBarHeight() => kToolbarHeight;

  /// Get bottom navigation bar height
  static double getBottomNavigationBarHeight() => kBottomNavigationBarHeight;

  /// Get keyboard height
  static double getKeyboardHeight() =>
      MediaQuery.of(Get.context!).viewInsets.bottom;

  /// Check if keyboard is visible
  static Future<bool> isKeyboardVisible() async {
    final insets = View.of(Get.context!).viewInsets;
    return insets.bottom > 0;
  }

  /// Check if running on a real physical device
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// Vibrate device for given duration
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  /// Set preferred device orientations
  static Future<void> setPreferredOrientations(
    List<DeviceOrientation> orientations,
  ) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  /// Hide the status bar
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// Show the status bar
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// Check if the device has internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  /// Check platform: iOS
  static bool isIOS() => Platform.isIOS;

  /// Check platform: Android
  static bool isAndroid() => Platform.isAndroid;

  /// Open an external URL
  /* 
  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  */
}
