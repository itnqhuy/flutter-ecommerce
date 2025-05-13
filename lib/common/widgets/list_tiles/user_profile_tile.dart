import 'package:ecommerce/common/widgets/images/my_circular_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyUserProfileTile extends StatelessWidget {
  const MyUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const MyCircularImage(
          image: MyImages.user, width: 50, height: 50, padding: 0),
      title: Text('NHuy',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: MyColors.white)),
      subtitle: Text('52200080@student.tdtu.edu.vn',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: MyColors.white)),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: MyColors.white)),
    ); // ListTile
  }
}
