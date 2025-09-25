import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/my_brand_title_text_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyCartItem extends StatelessWidget {
  const MyCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Image
        MyRoundedImage(
          imageUrl: item.image ?? '',
          isNetworkImage: true,
<<<<<<< HEAD
          width: 60,
          height: 60,
=======
          width: 80,
          height: 80,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
          padding: const EdgeInsets.all(MySizes.sm),
          backgroundColor: isDark ? MyColors.darkerGrey : MyColors.light,
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        //Title price and size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyBrandTitleWithVerifiedIcon(title: 'Dell'),
              Flexible(
                child: MyProductTitleText(
                    title: 'Laptop mau den sdvsvsdvsds', maxLines: 1),
              ),

              //Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Color',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'Green',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: 'Size',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'VN 08',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
