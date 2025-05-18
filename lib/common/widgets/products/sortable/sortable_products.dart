import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class MySortableProducts extends StatelessWidget {
  const MySortableProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;

    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            switch (value) {
              case 'Name':
                productController.sortByName();
                break;
              case 'Higher Price':
                productController.sortByPrice(descending: true);
                break;
              case 'Lower Price':
                productController.sortByPrice(descending: false);
                break;
              default:
                break;
            }
          },
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            // 'Sale', 'Newest', 'Popularity' có thể thêm sau
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: MySizes.md),

        // Products Grid
        Obx(
          () => MyGridLayout(
            itemCount: productController.displayedProducts.length,
            itemBuilder: (_, index) => MyProductCardVertical(
              product: productController.displayedProducts[index],
            ),
          ),
        ),
      ],
    );
  }
}
