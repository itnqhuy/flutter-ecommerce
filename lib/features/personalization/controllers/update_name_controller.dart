import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../screens/profile/profile.dart';
import 'user_controller.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  // Initialize the names from userController
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  // Update user's name in Firestore
  Future<void> updateUserName() async {
    try {
      MyFullScreenLoader.openLoadingDialog(
          'Chúng tôi đang cập nhật thông tin...', MyImages.loadingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // So sánh xem có thay đổi không
      final currentFirst = userController.user.value.firstName.trim();
      final currentLast = userController.user.value.lastName.trim();
      final newFirst = firstName.text.trim();
      final newLast = lastName.text.trim();

      if (currentFirst == newFirst && currentLast == newLast) {
        MyFullScreenLoader.stopLoading();
        MyLoaders.warningSnackBar(
            title: 'Không có thay đổi',
            message: 'Hãy nhập thông tin cần thay đổi');
        return;
      }

      // Tiến hành cập nhật
      Map<String, dynamic> name = {
        'firstName': newFirst,
        'lastName': newLast,
      };

      await userRepository.updateSingleField(name);

      userController.user.value = userController.user.value.copyWith(
        firstName: newFirst,
        lastName: newLast,
      );

      await UserRepository().updateSingleField(name);

      userController.user.value = userController.user.value.copyWith(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
      );

      MyFullScreenLoader.stopLoading();

      MyLoaders.successSnackBar(
          title: 'Chúc mừng', message: 'Tên của bạn đã được cập nhật.');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      MyFullScreenLoader.stopLoading();
      MyLoaders.errorSnackBar(title: 'Oops!!', message: e.toString());
    }
  }
}
