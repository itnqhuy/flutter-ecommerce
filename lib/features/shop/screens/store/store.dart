import 'package:ecommerce/features/shop/controllers/brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/animations/brand_shimmer.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/my_brand_card.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../brand/all_brands.dart';
import '../brand/brand_products.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('Cửa hàng',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            MyCartCounterIcon(iconColor: MyColors.accent),
          ],
        ), // TAppBar
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: MyHelperFunctions.isDarkMode(context)
                    ? MyColors.black
                    : MyColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //Search
                      const SizedBox(height: MySizes.spaceBtwItems),
                      MySearchContainer(
                          text: 'Tìm kiếm trong cửa hàng',
                          showBorder: true,
                          showBackground: false),
                      SizedBox(height: MySizes.spaceBtwSections),

                      //Feature brands
                      MySectionHeading(
                          title: 'Thương hiệu nổi bật',
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen())),
                      const SizedBox(height: MySizes.spaceBtwItems / 1.5),

                      Obx(() {
                        if (brandController.isLoading.value) {
                          return MyBrandShimmer();
                        }

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'Không tìm thấy dữ liệu',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return MyGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand =
                                  brandController.featuredBrands[index];
                              return MyBrandCard(
                                showBorder: true,
                                brand: brand,
                                onTap: () {
                                  Get.to(() => BrandProducts(brand: brand));
                                },
                              );
                            });
                      })
                    ],
                  ),
                ),

                //Tab_Bar
                bottom: MyTabBar(
                  tabs: categories
                      .map(
                        (category) => Tab(
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                ),
              ),
            ];
          },

          //Body
          body: TabBarView(
            children: categories
                .map((category) => MyCategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
