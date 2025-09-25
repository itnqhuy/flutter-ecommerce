import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/my_circular_icon.dart';

class MyProductQuanityWithAddRemoveButton extends StatelessWidget {
  const MyProductQuanityWithAddRemoveButton({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: MySizes.md,
          color: isDark ? MyColors.white : MyColors.black,
          backgroundColor: isDark ? MyColors.darkerGrey : MyColors.light,
          onPressed: onRemove,
        ),
        const SizedBox(width: MySizes.spaceBtwItems),
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: MySizes.spaceBtwItems),
        MyCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: MySizes.md,
          color: MyColors.white,
          backgroundColor: MyColors.primary,
          onPressed: onAdd,
        ),
      ],
    );
  }
}
