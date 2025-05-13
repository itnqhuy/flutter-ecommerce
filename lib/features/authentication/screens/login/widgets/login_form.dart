import 'package:ecommerce/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ecommerce/features/authentication/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class MyLoginForm extends StatelessWidget {
  const MyLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final rememberMe = false.obs;
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MySizes.spaceBtwSections),
        child: Column(
          children: [
            // Username or Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: MyTexts.email,
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwInputFields),
            // Password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: MyTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwInputFields / 2),
            // Remember me + Foget Pass
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: rememberMe.value,
                          onChanged: (value) => rememberMe.value = value!,
                        )),
                    const Text(MyTexts.rememberMe),
                  ],
                ),
                // Forget Pass
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(MyTexts.forgetPassword, style: TextStyle()),
                ),
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
            // SignIn
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text(MyTexts.signIn)),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),
            // Create Acc
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(MyTexts.createAccount)),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
