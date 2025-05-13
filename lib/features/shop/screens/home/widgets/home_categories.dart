import 'package:ecommerce/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:ecommerce/features/shop/screens/sub_category/sub_categories.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomeCategories extends StatelessWidget {
  const MyHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return MyVerticalImageText(
            image: MyImages.laptopCategory,
            title: 'Laptop',
            onTap: () => Get.to(() => const SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}
