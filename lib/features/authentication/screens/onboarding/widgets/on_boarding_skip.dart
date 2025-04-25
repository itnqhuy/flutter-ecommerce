import 'package:ecommerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      top: MyDeviceUtils.getAppBarHeight(),
      right: MySizes.defaultSpace,
      child: TextButton(
          onPressed: () => controller.skipPage(), child: const Text("Skip")),
    );
  }
}
