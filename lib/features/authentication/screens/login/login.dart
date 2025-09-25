import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/layout/responsive_container.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          padding: MySpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo + Title + SubTi
              const MyLoginHeader(),
              // Form Login
              MyLoginForm(),
              // Divider
              MyFormDevider(dividerText: MyTexts.orSignInWith.capitalize!),
              const SizedBox(height: MySizes.spaceBtwSections),
              // Footer
              MySocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
