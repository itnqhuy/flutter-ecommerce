import 'package:ecommerce/common/widgets/login_signup/form_divider.dart';
import 'package:ecommerce/common/widgets/login_signup/social_buttons.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/layouts/responsive_container.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          padding: MySpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Text(MyTexts.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: MySizes.spaceBtwSections),
              // Sign Up Form
              const MySignupForm(),
              const SizedBox(height: MySizes.spaceBtwSections),
              // Divider
              MyFormDevider(dividerText: MyTexts.orSignUpWith.capitalize!),
              const SizedBox(height: MySizes.spaceBtwSections),
              // Social
              const MySocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
