import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_format_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Local storage để kiểm tra onboarding đã xem hay chưa
  final deviceStorage = GetStorage();

  final _auth = FirebaseAuth.instance;
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect(_auth.currentUser);
  }

  /// Function to determine which screen to show
  screenRedirect(User? user) async {
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => OnBoardingScreen());
    }
  }

  // Đăng nhập

  // Đăng ký
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Có lỗi xảy ra. Vui lòng thử lại.';
    }
  }

  // [ReAuthenticate] - Xác thực lại người dùng

  // Xác minh email
  Future<void> sendEmailVerification() async {
    try {
      // Gửi email xác minh
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Có lỗi xảy ra. Vui lòng thử lại.';
    }
  }

  // [EmailAuthentication] - Quên mật khẩu

  // [GoogleAuthentication] - Google

  // [FacebookAuthentication] - Facebook

  // Hợp lệ với mọi phương thức đăng nhập
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Có lỗi xảy ra. Vui lòng thử lại.';
    }
  }

  // XÓA NGƯỜI DÙNG - Xóa xác thực và tài khoản Firestore của người dùng
}
