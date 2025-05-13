import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Bắt đầu hiển thị loading
      MyFullScreenLoader.openLoadingDialog(
          'Đang đăng nhập...', MyImages.loadingAnimation);

      // Kiểm tra kết nối internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Kiểm tra form hợp lệ
      if (!loginFormKey.currentState!.validate()) return;

      // Lưu dữ liệu nếu chọn "Remember Me"
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Đăng nhập người dùng với Email & Password
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Dừng hiển thị loading
      MyFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Dừng hiển thị loading nếu có lỗi
      MyFullScreenLoader.stopLoading();

      // Hiển thị thông báo lỗi
      MyLoaders.errorSnackBar(title: 'Oops!!', message: e.toString());
    } finally {
      // Dừng hiển thị loading
      MyFullScreenLoader.stopLoading();
    }
  }
}
