import 'package:ecommerce/common/widgets/icons/my_circular_icon.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:ecommerce/features/shop/controllers/cart_controller.dart';
=======
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import 'package:ecommerce/features/shop/models/sku_model.dart';
=======
>>>>>>> parent of 450796a (restore all)
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/product/sku_attribute_controller.dart';

class MyBottomAddToCart extends StatelessWidget {
  const MyBottomAddToCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: MySizes.defaultSpace, vertical: MySizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? MyColors.darkerGrey : MyColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MySizes.cardRadiusLg),
          topRight: Radius.circular(MySizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MyCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: MyColors.darkGrey,
                width: 40,
                height: 40,
                color: MyColors.white,
              ),
<<<<<<< HEAD

              /// Add to Cart Button
              ElevatedButton(
<<<<<<< HEAD
                onPressed: () => cartController.addToCart(sku),
=======
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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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
=======
              const SizedBox(height: MySizes.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: MySizes.spaceBtwItems),
              MyCircularIcon(
                icon: Iconsax.add,
                backgroundColor: MyColors.black,
                width: 40,
                height: 40,
                color: MyColors.white,
>>>>>>> parent of 450796a (restore all)
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(MySizes.md),
              backgroundColor: MyColors.black,
              side: const BorderSide(color: MyColors.black),
            ),
            child: const Text('Add to Cart'),
          )
        ],
      ),
    );
  }
}
