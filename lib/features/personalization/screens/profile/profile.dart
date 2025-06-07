import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/my_circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';
import 'widgets/change_name.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const MyAppBar(showBackArrow: true, title: Text('Thông tin')),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final imagePath = controller.user.value.avatarUrl;
                      final isLocalImage = File(imagePath).existsSync();
                      return isLocalImage
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(File(imagePath)),
                            )
                          : MyCircularImage(
                              image: MyImages.user, width: 80, height: 80);
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Thay đổi ảnh đại diện')),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Heading
              const MySectionHeading(
                  title: 'Thông tin người dùng', showActionButton: false),
              const SizedBox(height: MySizes.spaceBtwItems),

              Obx(
                () => MyProfileMenu(
                  title: 'Họ và tên',
                  value: controller.user.value.fullNameWithSpaces,
                  onPressed: () => Get.to(() => const ChangeName()),
                ),
              ),
              Obx(
                () => MyProfileMenu(
                    title: 'Tên đăng nhập',
                    value: controller.user.value.username,
                    onPressed: () {}),
              ),

              const SizedBox(height: MySizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Heading Personal Info
              const MySectionHeading(
                  title: 'Thông tin cá nhân', showActionButton: false),
              const SizedBox(height: MySizes.spaceBtwItems),

              MyProfileMenu(
                  title: 'ID người dùng',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onPressed: () {}),
              MyProfileMenu(
                  title: 'E-mail',
                  value: controller.user.value.email,
                  onPressed: () {}),
              MyProfileMenu(
                  title: 'Số điện thoại',
                  value: controller.user.value.phoneNumber ?? "",
                  onPressed: () {}),
              MyProfileMenu(title: 'Giới tính', value: 'Nam', onPressed: () {}),
              MyProfileMenu(
                  title: 'Ngày sinh', value: '22/08/2004', onPressed: () {}),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
