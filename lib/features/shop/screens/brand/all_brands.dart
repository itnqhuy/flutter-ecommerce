import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brands/my_brand_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand_controller.dart';
import 'brand_products.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.put(BrandController());

    return Scaffold(
      appBar: MyAppBar(title: const Text('Thương hiệu'), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          children: [
            const MySectionHeading(
                title: 'Thương hiệu', showActionButton: false),
            const SizedBox(height: MySizes.spaceBtwItems),

            // Body: theo dõi thay đổi allBrands và isLoading
            Expanded(
              child: Obx(() {
                if (brandController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (brandController.allBrands.isEmpty) {
                  return const Center(child: Text('Không có thương hiệu nào'));
                }

                return MyGridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    final brand = brandController.allBrands[index];
                    return MyBrandCard(
                      brand: brand,
                      showBorder: true,
                      onTap: () {
                        // Truyền brand hoặc brandId tùy BrandProducts
                        Get.to(() => BrandProducts(brand: brand));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
