import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/brands/my_brand_card.dart';
import 'package:ecommerce/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.find<BrandController>();

<<<<<<< HEAD
    // Gọi fetch products khi build, hoặc dùng binding / onInit nếu StatefulWidget
=======
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    brandController.fetchProductsByBrandId(brand.id);

    return Scaffold(
      appBar: MyAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // Brand Detail
              MyBrandCard(showBorder: true),
              SizedBox(height: MySizes.spaceBtwSections),
              MySortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
