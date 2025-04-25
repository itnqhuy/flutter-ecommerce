import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

import 'widgets/on_boarding_nextbutton.dart';
import 'widgets/on_boarding_page.dart';
import 'widgets/on_boarding_skip.dart';
import 'widgets/on_boarding_dotnavigation.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable Pages
          PageView(
            children: [
              OnBoardingPage(
                image: MyImages.onBoardingImage1,
                title: MyTexts.onBoardingTitle1,
                subtitle: MyTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: MyImages.onBoardingImage2,
                title: MyTexts.onBoardingTitle2,
                subtitle: MyTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: MyImages.onBoardingImage3,
                title: MyTexts.onBoardingTitle3,
                subtitle: MyTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // Skip Button
          OnBoardingSkip(),
          // Dot Navi At Bottom
          OnBoardingDotNavigation(),
          // Next Button At Bottom
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}
