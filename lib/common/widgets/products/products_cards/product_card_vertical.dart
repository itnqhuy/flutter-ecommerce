import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/styles/shadows.dart';
import 'package:ecommerce/common/widgets/icons/my_circular_icon.dart';
import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/my_brand_title_text_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_detail.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/brand_controller.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';

class MyProductCardVertical extends StatelessWidget {
  const MyProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);

    final brandController = Get.put(BrandController());
    brandController.loadBrandById(product.brandId);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        height: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [MyShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MySizes.productImageRadius),
          color: dark ? MyColors.darkGrey : MyColors.white,
        ),
        child: Column(
          children: [
            // Ảnh với icon trái tim + sale tag
            MyRoundedContainer(
              height: 185,
              backgroundColor: dark ? MyColors.dark : MyColors.light,
              child: Stack(
                children: [
                  // Ảnh không bị méo
                  Align(
                    alignment: Alignment.center,
                    child: MyRoundedImage(
                      imageUrl: product.imagesUrl.first,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  // Sale tag ở góc trên trái
                  Positioned(
                    top: 0,
                    left: 0,
                    child: MyRoundedContainer(
                      radius: MySizes.sm,
                      backgroundColor:
                          MyColors.secondary.withAlpha((255 * 0.8).round()),
                      padding: const EdgeInsets.symmetric(
                        horizontal: MySizes.sm,
                        vertical: MySizes.xs,
                      ),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: MyColors.black),
                      ),
                    ),
                  ),

                  // Favourite Icon
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: MyCircularIcon(
                      icon: Iconsax.heart,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            // Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyProductTitleText(title: product.name, smallSize: true),
                    SizedBox(height: MySizes.spaceBtwItems / 2),
                    Obx(() {
                      final brand = brandController.brandCache[product.brandId];
                      return MyBrandTitleWithVerifiedIcon(
                          title: brand?.name ?? 'Thương hiệu không rõ');
                    }),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Padding(
                  padding: EdgeInsets.only(left: MySizes.sm),
                  child: Obx(() {
                    final sku = ProductController.instance.skuCache[product.id];
                    final price = sku?.price ?? 0;
                    return MyProductPriceText(price: price);
                  }),
                ),

                // Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: MyColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MySizes.cardRadiusMd),
                      bottomRight: Radius.circular(MySizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: MySizes.iconLg * 1.2,
                    height: MySizes.iconLg * 1.2,
                    child:
                        Center(child: Icon(Iconsax.add, color: MyColors.white)),
                  ),
                ), // Container
              ],
            ),
          ],
        ),
      ),
    );
  }
}
