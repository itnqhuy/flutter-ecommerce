import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/styles/shadows.dart';
import 'package:ecommerce/common/widgets/icons/my_circular_icon.dart';
import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/my_brand_title_text_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyProductCardVertical extends StatelessWidget {
  const MyProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
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
              height: 80,
              padding: const EdgeInsets.all(MySizes.sm),
              backgroundColor: dark ? MyColors.dark : MyColors.light,
              child: Stack(
                children: [
                  // Ảnh không bị méo
                  const Align(
                    alignment: Alignment.center,
                    child: MyRoundedImage(
                      imageUrl: MyImages.productImage1,
                      applyImageRadius: true,
                    ),
                  ),

                  // Sale tag ở góc trên trái
                  Positioned(
                    top: 0,
                    left: 0,
                    child: MyRoundedContainer(
                      radius: MySizes.sm,
                      backgroundColor: MyColors.secondary.withOpacity(0.8),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.sm),
              // Only reason to use the [SizedBox] here is to make Column full Width
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyProductTitleText(
                        title: 'Green Nike Air Shoes sd sda dsa dsa dsd ',
                        smallSize: true),
                    SizedBox(height: MySizes.spaceBtwItems / 2),
                    MyBrandTitleWithVerifiedIcon(title: 'Nike'),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                const Padding(
                  padding: EdgeInsets.only(left: MySizes.sm),
                  child: MyProductPriceText(price: '35.0'),
                ), // Padding

                /// Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: MyColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MySizes.cardRadiusMd),
                      bottomRight: Radius.circular(MySizes.productImageRadius),
                    ),
                  ), // BoxDecoration
                  child: const SizedBox(
                    width: MySizes.iconLg * 1.2,
                    height: MySizes.iconLg * 1.2,
                    child:
                        Center(child: Icon(Iconsax.add, color: MyColors.white)),
                  ), // SizedBox
                ), // Container
              ],
            ), // Row
          ],
        ),
      ),
    );
  }
}


            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: MySizes.sm),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const SizedBox(height: MySizes.spaceBtwItems / 2),
            //         const MyProductTitleText(
            //           title: 'Laptop',
            //           smallSize: true,
            //         ),
            //         const SizedBox(height: MySizes.spaceBtwItems / 2),
            //         MyBrandTitleWithVerifiedIcon(title: 'DELL'),
            //         const Spacer(),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const MyProductPriceText(price: '35.0'),
            //             Container(
            //               decoration: const BoxDecoration(
            //                 color: MyColors.dark,
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(MySizes.cardRadiusMd),
            //                   bottomRight:
            //                       Radius.circular(MySizes.productImageRadius),
            //                 ),
            //               ),
            //               child: const SizedBox(
            //                 width: MySizes.iconLg * 1.2,
            //                 height: MySizes.iconLg * 1.2,
            //                 child: Center(
            //                   child: Icon(
            //                     Iconsax.add,
            //                     color: MyColors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         const SizedBox(height: MySizes.spaceBtwItems / 2),
            //       ],
            //     ),
            //   ),
            // ),