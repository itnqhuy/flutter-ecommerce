import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/animations/shimmer_effect.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return MyAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(MyTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: MyColors.grey)),
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const MyShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullNameWithSpaces,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: MyColors.white));
              }
            },
          ),
        ],
      ),
      actions: [
        MyCartCounterIcon(iconColor: MyColors.white),
      ],
    );
  }
}
