import 'package:ecommerce/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
<<<<<<< HEAD
=======
import '../../../controllers/category_controller.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';
import '../../all_products/all_products.dart';
=======
import 'package:get/get_core/src/get_main.dart';
>>>>>>> parent of 450796a (restore all)

class MyCategoryTab extends StatelessWidget {
  const MyCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
<<<<<<< HEAD
    ProductController.instance.fetchProductsByCategory(category.id);
=======
    final controller = CategoryController.instance;
    controller.fetchCategoryProducts(category.id);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
=======
>>>>>>> parent of 450796a (restore all)
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

<<<<<<< HEAD
              MyGridLayout(
<<<<<<< HEAD
                  itemCount: ProductController.instance.categoryProducts.length,
                  itemBuilder: (_, index) => MyProductCardVertical(
                        product:
                            ProductController.instance.categoryProducts[index],
                      ))
=======
              Obx(() => MyGridLayout(
                    itemCount: controller.categoryProducts.length,
                    itemBuilder: (_, index) => MyProductCardVertical(
                      product: controller.categoryProducts[index],
                    ),
                  ))
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
=======
                  itemCount: 4,
                  itemBuilder: (_, index) => const MyProductCardVertical())
>>>>>>> parent of 450796a (restore all)
            ],
          ),
        ),
      ],
    );
  }
}
