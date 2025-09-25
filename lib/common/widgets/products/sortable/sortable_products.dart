import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class MySortableProducts extends StatefulWidget {
  const MySortableProducts({super.key, required this.products});
  final List<ProductModel> products;

  @override
  State<MySortableProducts> createState() => _MySortableProductsState();
}

class _MySortableProductsState extends State<MySortableProducts> {
  final productController = ProductController.instance;

  String? selectedSortOption;

  @override
  void initState() {
    super.initState();
    productController.loadProducts(widget.products);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: selectedSortOption,
          hint: const Text('Lọc với'),
          onChanged: (value) {
            setState(() {
              selectedSortOption = value;
            });
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
              case 'Rating':
                productController.sortByRating(descending: true);
                break;
              default:
                break;
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
        ),
        const SizedBox(height: MySizes.md),
        Obx(
          () => MyGridLayout(
            itemCount: productController.sortableProducts.length,
            itemBuilder: (_, index) => MyProductCardVertical(
              product: productController.sortableProducts[index],
            ),
          ),
        ),
      ],
    );
  }
}
