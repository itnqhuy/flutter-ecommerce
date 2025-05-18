import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/styles/rounded_container.dart';
import '../../../../../common/widgets/images/my_circular_image.dart';
import '../../../../../common/widgets/texts/my_brand_title_text_verified_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/brand_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class MyProductMetaData extends StatelessWidget {
  const MyProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final brandController = BrandController.instance;
    final darkMode = MyHelperFunctions.isDarkMode(context);

    brandController.loadBrandById(product.brandId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Giá
        Row(
          children: [
            MyRoundedContainer(
              radius: MySizes.sm,
              backgroundColor:
                  MyColors.secondary.withAlpha((255 * 0.8).round()),
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
            Text(
              '₫250.000',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(width: MySizes.spaceBtwItems),
            Obx(() {
              final sku = productController.skuCache[product.id];
              return MyProductPriceText(
                price: sku?.price ?? 0,
                isLarge: true,
              );
            }),
          ],
        ),
        const SizedBox(width: MySizes.spaceBtwItems / 1.5),

        // Brand
        Obx(() {
          final brand = brandController.brandCache[product.brandId];
          return Row(
            children: [
              MyCircularImage(
                image: brand?.imageUrl ?? MyImages.laptopCategory,
                width: 32,
                height: 32,
                isNetworkImage: true,
                overLayColor: darkMode ? MyColors.white : MyColors.black,
              ),
              MyBrandTitleWithVerifiedIcon(
                title: brand?.name ?? 'Thương hiệu không rõ',
                brandTextSize: TextSizes.medium,
              ),
            ],
          );
        }),
      ],
    );
  }
}
