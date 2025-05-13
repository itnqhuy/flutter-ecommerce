import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  MyHomeAppBar(),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MySearchContainer(text: 'Search in store'),
                  SizedBox(height: MySizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.only(left: MySizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        MySectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: MySizes.spaceBtwItems),
                        MyHomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Body section
            Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: Column(
                children: [
                  //promo
                  MyPromoSlider(banners: [
                    MyImages.promoBanner1,
                    MyImages.promoBanner2,
                    MyImages.promoBanner3,
                    MyImages.promoBanner2,
                  ]),
                  SizedBox(height: MySizes.spaceBtwSections),

                  MySectionHeading(
                    title: 'Popular product',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),

                  //Products
                  MyGridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) => const MyProductCardVertical())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
