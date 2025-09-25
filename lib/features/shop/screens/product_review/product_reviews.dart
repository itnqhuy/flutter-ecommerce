import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerce/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:ecommerce/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/product_model.dart';
import '../../models/rating_model.dart';
import 'widgets/user_review_card.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Scaffold(
<<<<<<< HEAD
      appBar:
          MyAppBar(title: Text("Nhận xét và đánh giá"), showBackArrow: true),
<<<<<<< HEAD
=======
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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
=======
      appBar: MyAppBar(title: Text("Reviews & Ratings"), showBackArrow: true),
>>>>>>> parent of 450796a (restore all)

          final ratings = snapshot.data ?? [];

<<<<<<< HEAD
              // Overall Product Ratings
              const MyOverallProductRating(),
              MyRatingBarIndicator(rating: 3.5),
              Text("12,611", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: MySizes.spaceBtwItems),
=======
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Xếp hạng và đánh giá từ người dùng."),
                  SizedBox(height: MySizes.spaceBtwItems),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

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
