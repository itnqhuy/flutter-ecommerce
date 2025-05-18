import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/cart/cart.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            MyPrimaryHeaderContainer(
              child: Column(
                children: [
                  MyAppBar(
                      title: Text('Tài khoản của tôi',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: MyColors.white))),
                  MyUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            ),

            //body
            Padding(
              padding: EdgeInsets.all(MySizes.defaultSpace),
              child: Column(
                children: [
                  //Account settings
                  MySectionHeading(title: 'Cài đặt tài khoản'),
                  SizedBox(height: MySizes.spaceBtwItems),

                  // User Settings
                  MySettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'Địa chỉ',
                    subTitle: 'Đặt địa chỉ giao hàng của bạn',
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  MySettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'Giỏ hàng của tôi',
                    subTitle: 'Thêm, xóa sản phẩm và chuyển đến thanh toán',
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  MySettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'Đơn hàng của tôi',
                    subTitle: 'Đơn hàng đang xử lý và đã hoàn thành',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  MySettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Tài khoản ngân hàng',
                      subTitle: 'Withdraw balance to registered bank account'),
                  MySettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'Coupons của tôi',
                      subTitle: 'List of all the discounted coupons'),
                  MySettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message'),
                  MySettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),

                  /// -- App Settings
                  SizedBox(height: MySizes.spaceBtwSections),
                  MySectionHeading(
                      title: 'App Settings', showActionButton: false),
                  SizedBox(height: MySizes.spaceBtwItems),
                  MySettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload Data to your Cloud Firebase'),
                  MySettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  MySettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  MySettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  //logout
                  const SizedBox(height: MySizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text('Đăng xuất')),
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
