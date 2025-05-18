import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../images/my_circular_image.dart';

class MyBrandCard extends StatelessWidget {
  final bool showBorder;
  final void Function()? onTap;
  final BrandModel brand;

  const MyBrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
    );
  }
}
