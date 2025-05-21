import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/styles/rounded_container.dart';
import '../../../../../common/widgets/texts/my_brand_title_text_verified_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/brand_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../controllers/product/sku_attribute_controller.dart';
import '../../../models/product_model.dart';

class MyProductMetaData extends StatelessWidget {
  const MyProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final brandController = BrandController.instance;
    final skuAttrController = Get.isRegistered<SkuAttributeController>()
        ? Get.find<SkuAttributeController>()
        : Get.put(SkuAttributeController());
    final darkMode = MyHelperFunctions.isDarkMode(context);

    brandController.loadBrandById(product.brandId.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final hasSelectedSku =
              skuAttrController.selectedSku.value?.productId.id == product.id;

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
          final brand = brandController.brandCache[product.brandId.id];
          return Row(
            children: [
              MyBrandTitleWithVerifiedIcon(
                title: brand?.name ?? 'Không rõ thương hiệu',
                brandTextSize: TextSizes.large,
              ),
            ],
          );
        }),
      ],
    );
  }
}
