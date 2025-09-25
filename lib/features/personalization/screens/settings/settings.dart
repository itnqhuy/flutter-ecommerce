import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/address/adress.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  MyAppBar(
                      title: Text('Account',
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
                  //Acount settings
                  MySectionHeading(title: 'Account Settings'),
                  SizedBox(height: MySizes.spaceBtwItems),

                  // -- User Settings
                  MySettingsMenuTile(
                    icon: Iconsax.safe_home,
<<<<<<< HEAD
                    title: 'Địa chỉ',
=======
                    title: 'Địa chỉ của tôi',
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
                    subTitle: 'Đặt địa chỉ giao hàng của bạn',
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  MySettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => CartScreen()),
                  ),
                  MySettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  MySettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account'),
                  MySettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons'),
                  MySettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Thông báo',
                      subTitle: 'Thiết lập loại thông báo muốn nhận'),
                  MySettingsMenuTile(
                      icon: Iconsax.security_card,
<<<<<<< HEAD
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),
=======
                      title: 'Bảo mật tài khoản',
                      subTitle: 'Quản lý việc sử dụng dữ liệu và kết nối'),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

                  //logout
                  const SizedBox(height: MySizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
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
