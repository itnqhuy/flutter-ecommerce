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
<<<<<<< HEAD

<<<<<<< HEAD
    brandController.loadBrandById(product.brandId);
=======
    brandController.loadBrandById(product.brandId.id);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final hasSelectedSku =
<<<<<<< HEAD
              skuAttrController.selectedSku.value?.productId == product.id;
=======
              skuAttrController.selectedSku.value?.productId.id == product.id;
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

          // Lấy SKU giá thấp nhất
          final lowestPriceSku =
              productController.lowestPriceSkuCache[product.id];

          // Lấy giá gốc
          final original = hasSelectedSku
              ? skuAttrController.originalPrice.value
              : (lowestPriceSku?.price ?? 0);

          // Lấy giá đã giảm (nếu có) từ cache final price trong controller
          final discounted = hasSelectedSku
              ? skuAttrController.finalPrice.value
              : productController.lowestPriceSkuFinalPriceCache[product.id];

          // Kiểm tra có giảm giá hay không
          final hasDiscount = discounted != null && discounted < original;

          // Tính % giảm giá thực tế (làm tròn)
          final discountPercent = hasDiscount
              ? ((original - discounted) * 100 / original).round()
              : 0;

          return Row(
            children: [
              if (hasDiscount)
                MyRoundedContainer(
                  radius: MySizes.sm,
                  backgroundColor:
                      MyColors.secondary.withAlpha((255 * 0.8).round()),
                  padding: const EdgeInsets.symmetric(
                      horizontal: MySizes.sm, vertical: MySizes.xs),
                  child: Text(
                    '-$discountPercent%',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: MyColors.black),
                  ),
                ),
              if (hasDiscount) SizedBox(width: MySizes.spaceBtwItems),
              if (hasDiscount) ...[
                Text(
                  '₫$original',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: MyColors.grey,
                      ),
                ),
                const SizedBox(width: MySizes.spaceBtwItems / 2),
                MyProductPriceText(price: discounted, isLarge: true),
              ] else
                MyProductPriceText(price: original, isLarge: true),
            ],
          );
        }),
        const SizedBox(width: MySizes.spaceBtwItems),
        const SizedBox(height: MySizes.spaceBtwItems / 1.5),
        MyProductTitleText(
          title: product.name,
          textColor: darkMode ? MyColors.grey : MyColors.black,
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 1.5),
        Obx(() {
<<<<<<< HEAD
          final brand = brandController.brandCache[product.brandId];
=======
          final brand = brandController.brandCache[product.brandId.id];
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
          return Row(
            children: [
              MyBrandTitleWithVerifiedIcon(
                title: brand?.name ?? 'Không rõ thương hiệu',
                brandTextSize: TextSizes.large,
=======
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
>>>>>>> parent of 450796a (restore all)
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
