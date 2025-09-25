import 'package:flutter/material.dart';
import '../../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../models/rating_model.dart';

import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, required this.rating});

  final RatingModel rating;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(backgroundImage: AssetImage(MyImages.user)),
            const SizedBox(width: MySizes.spaceBtwItems),
            FutureBuilder<String>(
              future: controller.getUsernameById(rating.userId.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Đang tải...');
                } else if (snapshot.hasError) {
                  return const Text('Không rõ người dùng');
                } else {
                  return Text(snapshot.data ?? 'Ẩn danh',
                      style: Theme.of(context).textTheme.titleLarge);
                }
              },
            ),
          ],
        ),
        SizedBox(height: MySizes.spaceBtwItems),
        Row(
          children: [
            MyRatingBarIndicator(rating: rating.star.toDouble()),
            const SizedBox(width: MySizes.spaceBtwItems),
            Text('${rating.createdAt.toLocal()}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems),
        ReadMoreText(
          rating.description,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.primary),
          lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.primary),
        ),
        const SizedBox(width: MySizes.spaceBtwItems),
      ],
    );
  }
}
