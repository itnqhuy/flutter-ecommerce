import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/animations/vertical_product_shimmer.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        if (width < 320) {
          width = 320;
        } else if (width > 600) {
          width = 600;
        }
        return Center(
          child: SizedBox(
              width: width,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyPrimaryHeaderContainer(
                        child: Column(
                          children: [
                            MyHomeAppBar(),
                            SizedBox(height: MySizes.spaceBtwSections),
                            MySearchContainer(text: 'Search in store'),
                            SizedBox(height: MySizes.spaceBtwSections),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: MySizes.defaultSpace),
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
                            const MyPromoSlider(),
                            SizedBox(height: MySizes.spaceBtwSections),

                            MySectionHeading(
                              title: 'Popular product',
                              onPressed: () =>
                                  Get.to(() => const AllProducts()),
                            ),
                            SizedBox(height: MySizes.spaceBtwSections),

                            //Products
                            Obx(() {
                              if (productController.isLoading.value) {
                                return const MyVerticalProductShimmer();
                              }
                              if (productController.featuredProducts.isEmpty) {
                                return Center(
                                  child: Text("Không tìm thấy dữ liệu"),
                                );
                              }
                              return MyGridLayout(
                                itemCount:
                                    productController.featuredProducts.length,
                                itemBuilder: (_, index) =>
                                    MyProductCardVertical(
                                        product: productController
                                            .featuredProducts[index]),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
