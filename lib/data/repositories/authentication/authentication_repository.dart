import 'package:ecommerce/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_format_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Local storage để kiểm tra onboarding đã xem hay chưa
  final deviceStorage = GetStorage();

  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to determine which screen to show
  screenRedirect() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = _auth.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          await MyLocalStorage.init(user.uid);
          Get.offAll(() => NavigationMenu());
        } else {
          Get.offAll(() => VerifyEmailScreen(
                email: user.email,
              ));
        }
      } else {
        deviceStorage.writeIfNull('IsFirstTime', true);

        var isFirstTime = deviceStorage.read('IsFirstTime');

        if (isFirstTime == true) {
          Get.offAll(() => OnBoardingScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      }
    });
  }

  // Đăng nhập
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
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

  //Xác thực lại người dùng
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await _auth.currentUser!.reauthenticateWithCredential(credential);
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

  // Quên mật khẩu
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại.';
    }
  }

  // // [GoogleAuthentication] - Google
  // Future<UserCredential> signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await userAccount?.authentication;

  //     // Create a new credential
  //     final credentials = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

  //     // Once signed in, return the UserCredential
  //     return await _auth.signInWithCredential(credentials);
  //   } on FirebaseAuthException catch (e) {
  //     throw MyFirebaseAuthException(e.code, e.message);
  //   } on FirebaseException catch (e) {
  //     throw MyFirebaseAuthException(e.code, e.message);
  //   } on FormatException catch (_) {
  //     throw const MyFormatException();
  //   } on PlatformException catch (e) {
  //     throw MyPlatformException(e.code, e.message);
  //   } catch (e) {
  //     throw 'Đã xảy ra lỗi. Vui lòng thử lại.';
  //   }
  // }

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
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
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
}
