import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/user_model.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Đăng ký
  Future<void> signup() async {
    try {
      // Bắt đầu hiển thị Loading
      MyFullScreenLoader.openLoadingDialog(
          "Chúng tôi đang xử lý dữ liệu..", MyImages.loadingAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Kiểm tra hợp lệ form
      if (!signupFormKey.currentState!.validate()) return;

      // Kiểm tra Chính sách bảo mật
      if (!privacyPolicy.value) {
        MyLoaders.warningSnackBar(
          title: 'Chấp nhận Chính sách bảo mật',
          message:
              'Để tạo tài khoản, bạn phải đọc và chấp nhận Chính sách bảo mật & Điều khoản sử dụng.',
        );
        return;
      }

      // Đăng ký người dùng trong Firebase Authentication & Lưu dữ liệu người dùng vào Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Tạo UserModel với dữ liệu người dùng đã xác thực
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        avatarUrl: '',
        role: 'user',
        shippingInfo: null,
        isBanned: false,
        loyaltyPoints: 0,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      // Lưu UserModel vào Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Dừng hiển thị loading
      MyFullScreenLoader.stopLoading();

      // Hiển thị thông báo thành công
      MyLoaders.successSnackBar(
        title: 'Chúc mừng',
        message:
            'Tài khoản của bạn đã được tạo! Vui lòng xác minh email để tiếp tục.',
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (userCredential.user != null &&
            !userCredential.user!.emailVerified) {
          Get.to(
              () => VerifyEmailScreen(email: userCredential.user!.email ?? ''));
        }
      });
    } catch (e) {
      // Hiển thị thông báo lỗi chung cho người dùng
      MyLoaders.errorSnackBar(
          title: "Rất tiếc!!", message: "Chúng tôi đang gặp trục trặc...");
    } finally {
      // Dừng hiển thị loading
      MyFullScreenLoader.stopLoading();
    }
  }
}
