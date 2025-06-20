import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class MySortableProducts extends StatelessWidget {
  const MySortableProducts({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;

    // Gọi `loadProducts()` một lần trước khi hiển thị UI
    Future.delayed(Duration.zero, () {
      productController.loadProducts(products);
    });

    return Column(
      children: [
        Obx(() => DropdownButtonFormField<String>(
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
              value: productController.selectedSortOption.value,
              hint: const Text('Lọc với'),
              onChanged: (value) {
                if (value != null) {
                  productController.sortProducts(value);
                }
              },
              items: [
                'Tên',
                'Giá giảm dần',
                'Giá tăng dần',
                'Đánh giá',
              ]
                  .map((option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
            )),
        const SizedBox(height: MySizes.md),
        Obx(() => MyGridLayout(
              itemCount: productController.sortableProducts.length,
              itemBuilder: (_, index) => MyProductCardVertical(
                product: productController.sortableProducts[index],
              ),
            )),
      ],
    );
  }
}
