import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyVerticalImageText extends StatelessWidget {
  const MyVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = MyColors.white,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  bool get isNetworkImage => Uri.tryParse(image)?.isAbsolute ?? false;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: MySizes.spaceBtwItems),
        child: Column(
          children: [
            // Circular Image Container
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(MySizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? MyColors.grey : MyColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: isNetworkImage
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 24),
                      )
                    : Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
