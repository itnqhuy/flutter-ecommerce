import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/brand_controller.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/rounded_container.dart';
import '../../../styles/shadows.dart';
import '../../images/my_rounded_image.dart';
import '../../texts/my_brand_title_text_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../favorite_icon/favorite_icon.dart';

class MyProductCardVertical extends StatelessWidget {
  const MyProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);

    final brandController = Get.put(BrandController());
    brandController.loadBrandById(product.brandId.id);

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
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  // Ảnh không bị méo
                  Align(
                    alignment: Alignment.topCenter,
                    child: MyRoundedImage(
                      imageUrl: product.imagesUrl.first,
                      backgroundColor: dark ? MyColors.light : MyColors.grey,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  // Phần trăm giảm giá (nếu có)
                  Obx(() {
                    final discountPercent = ProductController.instance
                        .getLowestPriceWithPromotionPercent(product.id);
                    if (discountPercent <= 0) return const SizedBox.shrink();
                    return Positioned(
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
                          '-$discountPercent%',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: MyColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    );
                  }),
                  // Favourite Icon
                  Positioned(
                    top: 0,
                    right: 0,
                    child: MyFavoriteIcon(productId: product.id),
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
                      final brand =
                          brandController.brandCache[product.brandId.id];
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
                    final price = ProductController.instance
                        .getLowestPriceWithPromotion(product.id);
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
