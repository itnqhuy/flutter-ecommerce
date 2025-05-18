import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/screens/login/login.dart';
import '../models/user_model.dart';
import '../screens/profile/widgets/re_auth_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final hidePassword = false.obs;
  final uploadImage = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final UserRepository userRepository = Get.put(UserRepository());
  final GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if data is alrd stored.
      await fetchUserRecord();

      if (userCredentials != null) {
        // Convert Name to First and Last Name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        // Map data to UserModel
        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts.isNotEmpty ? nameParts[0] : '',
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          avatarUrl: userCredentials.user!.photoURL ?? '',
          role: 'user',
          shippingInfo: null,
          isBanned: false,
          loyaltyPoints: 0,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        );

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      MyLoaders.warningSnackBar(
        title: 'Dữ liệu chưa được lưu!',
        message:
            'Đã xảy ra lỗi khi lưu thông tin của bạn. Bạn có thể thử lưu lại trong hồ sơ của mình.',
      );
    }
  }

  // Function to show the warning popup before deleting the account
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MySizes.md),
      title: 'Xóa tài khoản',
      middleText:
          'Bạn có chắc chắn muốn xóa tài khoản của mình vĩnh viễn không? Hành động này không thể quay lại và tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn.',
      confirm: ElevatedButton(
        onPressed: () async {
          await _deleteUserAccount();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MySizes.lg),
          child: Text('Xóa'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Hủy'),
        onPressed: () {
          Navigator.of(Get.overlayContext!).pop();
        },
      ),
    );
  }

  // Delete user account from Firebase
  Future<void> _deleteUserAccount() async {
    try {
      MyFullScreenLoader.openLoadingDialog(
          'Đang xử lý', MyImages.loadingAnimation);

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // // Kiểm tra phương thức đăng nhập để xác thực lại email
        // if (provider == 'google.com') {
        //   // Đăng nhập lại bằng Google
        //   await auth.signInWithGoogle();
        //   await auth.deleteAccount();  // Xóa tài khoản Firebase
        //   MyFullScreenLoader.stopLoading();
        //   Get.offAll(() => const LoginScreen());  // Điều hướng đến màn hình đăng nhập
        // } else if (provider == 'password') {
        //   // Xác thực lại bằng mật khẩu
        //   MyFullScreenLoader.stopLoading();
        //   Get.to(() => const ReAuthLoginForm());  // Điều hướng đến màn hình xác thực lại mật khẩu
        // }
        if (provider == 'password') {
          MyFullScreenLoader.stopLoading();
          Get.to(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      MyLoaders.errorSnackBar(
        title: 'Lỗi',
        message: 'Có lỗi xảy ra khi xóa tài khoản của bạn. Hãy thử lại.',
      );
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      MyFullScreenLoader.openLoadingDialog(
          'Đang xử lý', MyImages.loadingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      if (!reAuthFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());

      await AuthenticationRepository.instance.deleteAccount();

      MyFullScreenLoader.stopLoading();

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      MyFullScreenLoader.stopLoading();
      MyLoaders.warningSnackBar(
        title: 'Oops!!',
        message: e.toString(),
      );
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      // Pick image from gallery
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        uploadImage.value = true;
        // Upload image to Firebase Storage
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile/',
          image,
        );

        final json = {'avatarUrl': imageUrl};
        await userRepository.updateSingleField(json);

        // Update local user model
        user.value = user.value.copyWith(avatarUrl: imageUrl);
        user.refresh();

        // Show success message
        MyLoaders.successSnackBar(
          title: 'Chúc mừng',
          message: 'Ảnh đại diện đã được cập nhật!',
        );
      }
    } catch (e) {
      // Show error message
      MyLoaders.errorSnackBar(
        title: 'Oops!',
        message: e.toString(),
      );
    } finally {
      uploadImage.value = true;
    }
  }
}
