import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../layout/responsive_container.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // Success Anima
              Lottie.asset(
                image,
                width: MyHelperFunctions.screenWidth() * 0.6,
                repeat: false,
                animate: true,
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),

              // SubTitle
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(MyTexts.continueText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
