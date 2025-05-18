import 'package:ecommerce/features/shop/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/animations/category_shimmer.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../sub_category/sub_categories.dart';

class MyHomeCategories extends StatelessWidget {
  const MyHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final categoryController = Get.find<CategoryController>();

    return Obx(() {
      if (categoryController.isLoading.value) return const MyCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            "Không tìm thấy dữ liệu",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryController.featuredCategories.length,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return MyVerticalImageText(
              backgroundColor: dark ? MyColors.grey : MyColors.white,
              image: category.imageUrl,
              title: category.name,
              onTap: () =>
                  Get.to(() => SubCategoriesScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}
