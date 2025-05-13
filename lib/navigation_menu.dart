import 'package:ecommerce/features/personalization/screens/settings/settings.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/features/shop/screens/store/store.dart';
import 'package:ecommerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = MyHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? MyColors.black : Colors.white,
          indicatorColor: darkMode
              // ignore: deprecated_member_use
              ? MyColors.white.withOpacity(0.1)
              // ignore: deprecated_member_use
              : MyColors.black.withOpacity(0.1),
          destinations: [
            const NavigationDestination(
                icon: Icon(Iconsax.home), label: 'Home'),
            const NavigationDestination(
                icon: Icon(Iconsax.shop), label: 'Store'),
            const NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Wishlist'),
            const NavigationDestination(
                icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingsScreen()
  ];
}
