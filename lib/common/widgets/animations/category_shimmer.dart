import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'shimmer_effect.dart';

class MyCategoryShimmer extends StatelessWidget {
  const MyCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(width: MySizes.spaceBtwItems),
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer cho hình ảnh
            const MyShimmerEffect(width: 55, height: 55, radius: 55),
            const SizedBox(height: MySizes.spaceBtwItems / 2),

            // Shimmer cho dòng chữ
            const MyShimmerEffect(width: 55, height: 8),
          ],
        ),
      ),
    );
  }
}
