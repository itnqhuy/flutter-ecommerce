import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rounded_container.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/my_circular_image.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../common/widgets/texts/my_brand_title_text_verified_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  final BrandModel brand;

  const BrandProducts({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.find<BrandController>();

    // Gọi fetch products khi build, hoặc dùng binding / onInit nếu StatefulWidget
    brandController.fetchProductsByBrandId(brand.id);

    return Scaffold(
      appBar: MyAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // Brand info with logo + total products text
              Obx(() {
                final dark = MyHelperFunctions.isDarkMode(context);
                final productCount = brandController.brandProducts.length;

                return MyRoundedContainer(
                  padding: const EdgeInsets.all(MySizes.sm),
                  showBorder: true,
                  backgroundColor: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: MyColors.lightGrey,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: dark ? Colors.white : Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: MyCircularImage(
                            isNetworkImage: true,
                            image: brand.imageUrl,
                            backgroundColor: MyColors.lightGrey,
                          ),
                        ),
                      ),
                      const SizedBox(width: MySizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyBrandTitleWithVerifiedIcon(
                              title: brand.name,
                              brandTextSize: TextSizes.large,
                            ),
                            const SizedBox(height: MySizes.spaceBtwItems / 2),
                            Text(
                              '$productCount sản phẩm',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: MySizes.spaceBtwItems),

              Obx(() {
                if (brandController.isLoadingProducts.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (brandController.brandProducts.isEmpty) {
                  return const Center(child: Text('Không có sản phẩm'));
                }
                return MySortableProducts(
                    products: brandController.brandProducts);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
