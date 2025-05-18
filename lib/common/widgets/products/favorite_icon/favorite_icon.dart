import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/favorite_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../icons/my_circular_icon.dart';

class MyFavoriteIcon extends StatelessWidget {
  const MyFavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());

    return Obx(
      () => MyCircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart : Iconsax.heart,
        color: controller.isFavorite(productId) ? MyColors.error : null,
        onPressed: () => controller.toggleFavoriteProduct(productId),
      ),
    );
  }
}
