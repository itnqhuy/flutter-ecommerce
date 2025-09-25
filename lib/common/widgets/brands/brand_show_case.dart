import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyBrandShowCase extends StatelessWidget {
  const MyBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return MyRoundedContainer(
      showBorder: true,
      borderColor: MyColors.darkGrey,
      padding: const EdgeInsets.all(MySizes.md),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: MySizes.spaceBtwItems),
      child: Column(
        children: [
          //const MyBrandCard(showBorder: false),
          const SizedBox(height: MySizes.spaceBtwItems),
          //brand top3
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          )
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: MyRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(MySizes.md),
      margin: const EdgeInsets.only(right: MySizes.sm),
      backgroundColor: MyHelperFunctions.isDarkMode(context)
          ? MyColors.darkerGrey
          : MyColors.light,
      child: Image(
        fit: BoxFit.contain,
        image: AssetImage(image),
      ),
    ), // MyRoundedContainer
  ); // Expanded
}
