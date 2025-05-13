import 'package:ecommerce/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyCategoryTab extends StatelessWidget {
  const MyCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              //Brands
              MyBrandShowCase(
                images: [
                  MyImages.productImage1,
                  MyImages.productImage11,
                  MyImages.productImage12
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              //Products
              MySectionHeading(
                  title: 'You might like',
                  onPressed: () => Get.to(() => const AllProducts())),
              const SizedBox(height: MySizes.spaceBtwItems),

              MyGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => const MyProductCardVertical())
            ],
          ),
        ),
      ],
    );
  }
}
