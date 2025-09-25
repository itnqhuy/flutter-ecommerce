import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';
import '../../all_products/all_products.dart';

class MyCategoryTab extends StatelessWidget {
  const MyCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    ProductController.instance.fetchProductsByCategory(category.id);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              //Products
              MySectionHeading(
                title: 'Sản phẩm nổi bật',
                onPressed: () => Get.to(() => AllProducts(
                    title: category.name,
                    query: FirebaseFirestore.instance
                        .collection('Products')
                        .where('idCategory',
                            isEqualTo: FirebaseFirestore.instance
                                .doc('Categories/${category.id}'))
                        .limit(6),
                    futureMethod: ProductController.instance
                        .fetchProductsByCategory(category.id))),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              MyGridLayout(
                  itemCount: ProductController.instance.categoryProducts.length,
                  itemBuilder: (_, index) => MyProductCardVertical(
                        product:
                            ProductController.instance.categoryProducts[index],
                      ))
            ],
          ),
        ),
      ],
    );
  }
}
