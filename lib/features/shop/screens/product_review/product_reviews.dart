import 'package:flutter/material.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/product_model.dart';
import '../../models/rating_model.dart';
import 'widgets/user_review_card.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Scaffold(
      appBar:
          MyAppBar(title: Text("Nhận xét và đánh giá"), showBackArrow: true),
      body: FutureBuilder<List<RatingModel>>(
        future: controller.getRatingsByProduct(product.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Chưa có đánh giá nào!"));
          }

          final ratings = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Xếp hạng và đánh giá từ người dùng."),
                  SizedBox(height: MySizes.spaceBtwItems),

                  // Hiển thị danh sách đánh giá
                  Column(
                    children: ratings
                        .map((rating) => UserReviewCard(rating: rating))
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
