import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';

class MyCartCounterIcon extends StatelessWidget {
  const MyCartCounterIcon({
    super.key,
    required this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() {
      final totalItems = cartController.noOfCartItems.value;

      return Stack(
        children: [
          IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            ),
          ),
          if (totalItems > 0)
            Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: MyColors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    totalItems.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: MyColors.white, fontSizeFactor: 0.8),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
