import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Local storage để kiểm tra onboarding đã xem hay chưa
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to determine which screen to show
  Future<void> screenRedirect() async {
    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => OnBoardingScreen());
  }

  /* ----------------------- Đăng nhập bằng Email & Mật khẩu ----------------------- */

  /// [EmailAuthentication] - Đăng nhập
  /// [EmailAuthentication] - Đăng ký
  /// [ReAuthenticate] - Xác thực lại người dùng
  /// [EmailVerification] - Xác minh email
  /// [EmailAuthentication] - Quên mật khẩu

  /* ------------------- Đăng nhập liên kết mạng xã hội ------------------- */

  /// [GoogleAuthentication] - Google
  /// [FacebookAuthentication] - Facebook

  /* ------------------ ./kết thúc mạng xã hội ------------------ */

  /// [LogoutUser] - Hợp lệ với mọi phương thức đăng nhập

  /// XÓA NGƯỜI DÙNG - Xóa xác thực và tài khoản Firestore của người dùng
}
