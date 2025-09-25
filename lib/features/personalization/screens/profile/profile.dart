<<<<<<< HEAD
import 'package:ecommerce/common/widgets/animations/shimmer_effect.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/images/my_circular_image.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
=======
import 'dart:io';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

<<<<<<< HEAD
import '../../controllers/user_controller.dart';
import 'widgets/change_name.dart';
=======
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/my_circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';
import 'widgets/change_name.dart';
import 'widgets/profile_menu.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(showBackArrow: true, title: Text('Profile')),

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
<<<<<<< HEAD
                      final networkImage = controller.user.value.avatarUrl;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : MyImages.user;
                      return controller.uploadImage.value
                          ? const MyShimmerEffect(
                              width: 80, height: 80, radius: 80)
                          : MyCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
=======
                      final imagePath = controller.user.value.avatarUrl;
                      final isLocalImage = File(imagePath).existsSync();
                      return isLocalImage
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(File(imagePath)),
                            )
                          : MyCircularImage(
                              image: MyImages.user, width: 80, height: 80);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
                    }),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Heading Profile Info
              const MySectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: MySizes.spaceBtwItems),

              MyProfileMenu(title: 'Name', value: 'NHuy', onPressed: () {}),
              MyProfileMenu(
                  title: 'Username', value: 'NHuy_341', onPressed: () {}),

              const SizedBox(height: MySizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// Heading Personal Info
              const MySectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: MySizes.spaceBtwItems),

              MyProfileMenu(
                  title: 'User ID',
                  value: '52200080',
                  icon: Iconsax.copy,
                  onPressed: () {}),
              MyProfileMenu(
                  title: 'E-mail',
                  value: '52200080@gmail.com',
                  onPressed: () {}),
              MyProfileMenu(
<<<<<<< HEAD
                  title: ' Số điện thoại',
=======
                  title: 'Số điện thoại',
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
                  value: controller.user.value.phoneNumber ?? "",
                  onPressed: () {}),
              const Divider(),
              const SizedBox(height: MySizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {},
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
