import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class MyRatingAndShare extends StatelessWidget {
  const MyRatingAndShare({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
<<<<<<< HEAD
=======
    controller.loadProductRatings(product.id);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          children: [
            const Icon(Iconsax.star, color: Colors.amber, size: 24),
            const SizedBox(width: MySizes.spaceBtwItems / 2),
            Obx(() {
              final avg = controller.productRatingCache[product.id] ?? 0.0;
              final count = controller.productRatingCountCache[product.id] ?? 0;
              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: avg.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(text: ' ($count)'),
                  ],
                ),
              );
            }),
          ],
        ),

        // Share button
        IconButton(
          onPressed: () {
            // share logic ở đây
          },
          icon: const Icon(Icons.share, size: MySizes.iconMd),
        ),
      ],
    );
  }
}
