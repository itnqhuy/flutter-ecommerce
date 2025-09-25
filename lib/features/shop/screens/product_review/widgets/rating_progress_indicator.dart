import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';
import 'progress_indicator_and_rating.dart';

class MyOverallProductRating extends StatelessWidget {
  const MyOverallProductRating({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;

    return Obx(() {
      final avgRating = productController.getAverageRating(product.id);
      final ratingCountMap =
          productController.getRatingCountByStars(product.id);
      final totalCount =
          ratingCountMap.values.fold<int>(0, (sum, count) => sum + count);

      double getProgress(int star) =>
          totalCount == 0 ? 0.0 : (ratingCountMap[star] ?? 0) / totalCount;

      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  avgRating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '($totalCount)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: List.generate(5, (index) {
                final star = 5 - index;
                return MyRatingProgressIndicator(
                  text: star.toString(),
                  value: getProgress(star),
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
