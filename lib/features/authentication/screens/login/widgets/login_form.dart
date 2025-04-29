import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class MyLoginForm extends StatelessWidget {
  const MyLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(MyTexts.rememberMe),
                  ],
                ),
                // Forget Pass
                TextButton(
                  onPressed: () {},
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
                  onPressed: () {}, child: const Text(MyTexts.createAccount)),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
