import 'package:ecommerce/common/widgets/icons/my_circular_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/features/shop/models/sku_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/product/sku_attribute_controller.dart';

class MyBottomAddToCart extends StatelessWidget {
  const MyBottomAddToCart({
    super.key,
    required this.sku,
  });

  final SkuModel sku;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MySizes.defaultSpace,
        vertical: MySizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? MyColors.darkerGrey : MyColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MySizes.cardRadiusLg),
          topRight: Radius.circular(MySizes.cardRadiusLg),
        ),
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Quantity Selector
              Row(
                children: [
                  MyCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: MyColors.darkGrey,
                    width: 40,
                    height: 40,
                    color: MyColors.white,
                    onPressed: cartController.decreaseQuantity,
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),
                  Text(
                    cartController.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: MySizes.spaceBtwItems),
                  MyCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: MyColors.black,
                    width: 40,
                    height: 40,
                    color: MyColors.white,
                    onPressed: cartController.increaseQuantity,
                  ),
                ],
              ),

              /// Add to Cart Button
              ElevatedButton(
                onPressed: () async {
                  final skuAttriController = SkuAttributeController.instance;
                  if (await skuAttriController.isSelectionComplete()) {
                    cartController.addToCart(sku);
                  } else {
                    Get.snackbar(
                      'Chưa đầy đủ phân loại',
                      'Hãy chọn đầy đủ phân loại nhé',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(MySizes.md),
                  backgroundColor: dark ? MyColors.grey : MyColors.black,
                  side:
                      BorderSide(color: dark ? MyColors.grey : MyColors.black),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.shopping_bag,
                      size: 20,
                      color: dark ? MyColors.black : MyColors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: dark ? MyColors.black : MyColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
