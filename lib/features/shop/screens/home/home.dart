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
    final controller = Get.put(ProductController());

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
<<<<<<< HEAD
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
                            MySearchContainer(text: 'Tìm kiếm trong cửa hàng'),
                            SizedBox(height: MySizes.spaceBtwSections),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: MySizes.defaultSpace),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  MySectionHeading(
                                    title: 'Phân loại phổ biến',
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
                      Padding(
                        padding: const EdgeInsets.all(MySizes.defaultSpace),
                        child: Column(
                          children: [
                            const MyPromoSlider(),
                            SizedBox(height: MySizes.spaceBtwSections),
                            MySectionHeading(
                              title: 'Popular product',
                              onPressed: () => Get.to(() => AllProducts(
                                    title: 'Popular product',
                                    query: FirebaseFirestore.instance
                                        .collection('Products')
                                        .where('isFeatured', isEqualTo: true)
                                        .limit(6),
                                    futureMethod:
                                        controller.fetchAllFeaturedProducts(),
                                  )),
                            ),
                            SizedBox(height: MySizes.spaceBtwSections),
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const MyVerticalProductShimmer();
                              }
                              if (controller.featuredProducts.isEmpty) {
                                return const Center(
                                  child: Text("Không tìm thấy dữ liệu"),
                                );
                              }
                              return MyGridLayout(
                                itemCount: controller.featuredProducts.length,
                                itemBuilder: (_, index) =>
                                    MyProductCardVertical(
                                        product:
                                            controller.featuredProducts[index]),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
=======
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
                    Padding(
                      padding: const EdgeInsets.all(MySizes.defaultSpace),
                      child: Column(
                        children: [
                          const MyPromoSlider(),
                          SizedBox(height: MySizes.spaceBtwSections),
                          MySectionHeading(
                            title: 'Sản phẩm nổi bật',
                            onPressed: () => Get.to(
                              () => AllProducts(
                                title: 'Tất cả sản phẩm',
                                query: FirebaseFirestore.instance
                                    .collection('Products'),
                                futureMethod:
                                    controller.fetchAllFeaturedProducts(),
                              ),
                            ),
                          ),
                          SizedBox(height: MySizes.spaceBtwSections),
                          Obx(() {
                            if (controller.isLoading.value) {
                              return const MyVerticalProductShimmer();
                            }
                            if (controller.featuredProducts.isEmpty) {
                              return const Center(
                                child: Text("Không tìm thấy dữ liệu"),
                              );
                            }
                            return MyGridLayout(
                              itemCount: controller.featuredProducts.length,
                              itemBuilder: (_, index) => MyProductCardVertical(
                                  product: controller.featuredProducts[index]),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
        );
      },
    );
  }
}
