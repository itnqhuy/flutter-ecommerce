import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/login/login.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    try {
      MyFullScreenLoader.openLoadingDialog(
        'Đang xử lý yêu cầu...',
        MyImages.deliveredEmailIllustration,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      MyFullScreenLoader.stopLoading();

      MyLoaders.successSnackBar(
        title: 'Thành công',
        message: 'Mã đặt lại mật khẩu đã được gửi đến email của bạn.',
      );

      // Chuyển hướng
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      MyFullScreenLoader.stopLoading();
      MyLoaders.errorSnackBar(
        title: 'Lỗi',
        message: 'Đã xảy ra lỗi. Vui lòng thử lại.',
      );
    } finally {
      MyFullScreenLoader.stopLoading();
    }
  }

  Future<void> resendPasswordResetEmail(String email) async {
    try {
      MyFullScreenLoader.openLoadingDialog(
        'Đang xử lý yêu cầu...',
        MyImages.deliveredEmailIllustration,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Gửi email đặt lại mật khẩu
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.trim());

      MyFullScreenLoader.stopLoading();

      // Hiển thị thông báo thành công
      MyLoaders.successSnackBar(
        title: 'Email đã được gửi',
        message: 'Liên kết đặt lại mật khẩu đã được gửi đến email của bạn.'.tr,
      );

      Get.offAll(() => LoginScreen());
    } catch (e) {
      MyFullScreenLoader.stopLoading();

      MyLoaders.errorSnackBar(
        title: 'Lỗi',
        message: 'Đã xảy ra lỗi. Vui lòng thử lại.',
      );
    } finally {
      MyFullScreenLoader.stopLoading();
    }
  }
}
