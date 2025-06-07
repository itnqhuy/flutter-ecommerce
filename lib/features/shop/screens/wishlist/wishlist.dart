import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/my_circular_icon.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/favorite_controller.dart';

// Example of correctly observing favorites state
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());

    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          MyCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const NavigationMenu()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Obx(() {
            final favoriteList = controller.favoriteProductList;

            if (favoriteList.isEmpty) {
              return MyAnimationLoaderWidget(
                text: 'Mục yêu thích của bạn trống',
                animation: MyImages.loveAnimation,
                onActionPressed: () => Get.off(() => const NavigationMenu()),
              );
            }

            return MyGridLayout(
              itemCount: favoriteList.length,
              itemBuilder: (_, index) =>
                  MyProductCardVertical(product: favoriteList[index]),
            );
          }),
        ),
      ),
    );
  }
}
