import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(MyImages.user)),
                SizedBox(width: MySizes.spaceBtwItems),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        SizedBox(height: MySizes.spaceBtwItems),

        //Reviews
        Row(
          children: [
            MyRatingBarIndicator(rating: 4),
            const SizedBox(width: MySizes.spaceBtwItems),
            Text('01 Nov 2023', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(width: MySizes.spaceBtwItems),
        const ReadMoreText(
          'Laptop là một thiết bị công nghệ không thể thiếu trong cuộc sống hiện đại, phục vụ cho nhiều mục đích như học tập, làm việc và giải trí. Với sự phát triển của công nghệ, laptop ngày càng trở nên mạnh mẽ, gọn nhẹ và dễ dàng mang theo bên mình. Các dòng laptop hiện nay được trang bị các cấu hình mạnh mẽ với bộ vi xử lý hiệu suất cao, bộ nhớ RAM lớn và ổ cứng SSD, giúp người dùng thực hiện các tác vụ nặng như thiết kế đồ họa, chỉnh sửa video, hay chơi game mượt mà',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.primary),
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        // Company Review
        MyRoundedContainer(
          backgroundColor: dark ? MyColors.darkerGrey : MyColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(MySizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("NHuy's Store",
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('02 Nov, 2023',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(width: MySizes.spaceBtwItems),
                const ReadMoreText(
                  'Laptop là một thiết bị công nghệ không thể thiếu trong cuộc sống hiện đại, phục vụ cho nhiều mục đích như học tập, làm việc và giải trí. Với sự phát triển của công nghệ, laptop ngày càng trở nên mạnh mẽ, gọn nhẹ và dễ dàng mang theo bên mình. Các dòng laptop hiện nay được trang bị các cấu hình mạnh mẽ với bộ vi xử lý hiệu suất cao, bộ nhớ RAM lớn và ổ cứng SSD, giúp người dùng thực hiện các tác vụ nặng như thiết kế đồ họa, chỉnh sửa video, hay chơi game mượt mà',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: MySizes.spaceBtwSections),
      ],
    );
  }
}
