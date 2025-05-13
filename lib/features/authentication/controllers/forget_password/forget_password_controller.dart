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

      // Kiểm tra kết nối internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Kiểm tra form hợp lệ
      if (!forgetPasswordFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      MyFullScreenLoader.stopLoading();

      // Nếu thành công, bạn có thể thực hiện các thao tác tiếp theo, chẳng hạn như thông báo thành công
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
      // Đóng màn hình loading sau khi xử lý xong
      MyFullScreenLoader.stopLoading();
    }
  }

  Future<void> resendPasswordResetEmail(String email) async {
    try {
      // Hiển thị màn hình loading
      MyFullScreenLoader.openLoadingDialog(
        'Đang xử lý yêu cầu...',
        MyImages.deliveredEmailIllustration,
      );

      // Kiểm tra kết nối mạng
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Kiểm tra tính hợp lệ của dữ liệu form
      if (!forgetPasswordFormKey.currentState!.validate()) return;

      // Gửi email đặt lại mật khẩu
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.trim());

      // Dừng màn hình loading sau khi gửi xong
      MyFullScreenLoader.stopLoading();

      // Hiển thị thông báo thành công
      MyLoaders.successSnackBar(
        title: 'Email đã được gửi',
        message: 'Liên kết đặt lại mật khẩu đã được gửi đến email của bạn.'.tr,
      );

      // Chuyển hướng người dùng nếu cần (ví dụ: quay lại trang login)
      Get.offAll(() => LoginScreen());
    } catch (e) {
      // Dừng loading nếu có lỗi xảy ra
      MyFullScreenLoader.stopLoading();

      // Hiển thị thông báo lỗi
      MyLoaders.errorSnackBar(
        title: 'Lỗi',
        message: 'Đã xảy ra lỗi. Vui lòng thử lại.',
      );
    } finally {
      // Đóng màn hình loading sau khi xử lý xong
      MyFullScreenLoader.stopLoading();
    }
  }
}
