import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import the GetX package

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class MyTermsAndCondition extends StatelessWidget {
  const MyTermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value),
          ),
        ),
        const SizedBox(width: MySizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: '${MyTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${MyTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: dark ? MyColors.white : MyColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? MyColors.white : MyColors.primary,
                    ),
              ),
              TextSpan(
                text: '${MyTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: MyTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: dark ? MyColors.white : MyColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? MyColors.white : MyColors.primary,
                    ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
