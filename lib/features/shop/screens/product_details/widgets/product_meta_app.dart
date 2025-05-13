import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/images/my_circular_image.dart';
import 'package:ecommerce/common/widgets/texts/my_brand_title_text_verified_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyProductMetaData extends StatelessWidget {
  const MyProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = MyHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale Price
        Row(
          children: [
            // Sale Tag
            MyRoundedContainer(
              radius: MySizes.sm,
              // ignore: deprecated_member_use
              backgroundColor: MyColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: MySizes.sm, vertical: MySizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: MyColors.black),
              ),
            ),
            const SizedBox(width: MySizes.spaceBtwItems),

            //Price
            Text('\$250',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: MySizes.spaceBtwItems),
            MyProductPriceText(price: '175', isLarge: true),
          ],
        ),
        const SizedBox(width: MySizes.spaceBtwItems / 1.5),

        // Title
        MyProductTitleText(title: 'Laptop ne ban'),
        const SizedBox(width: MySizes.spaceBtwItems / 1.5),

        //Stock
        Row(
          children: [
            MyProductTitleText(title: 'Status'),
            const SizedBox(width: MySizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(width: MySizes.spaceBtwItems / 1.5),

        //Brands
        Row(
          children: [
            MyCircularImage(
              image: MyImages.laptopCategory,
              width: 32,
              height: 32,
              overLayColor: darkMode ? MyColors.white : MyColors.black,
            ),
            MyBrandTitleWithVerifiedIcon(
                title: 'Dell', brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
