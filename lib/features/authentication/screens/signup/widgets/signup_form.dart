import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'terms_and_condition.dart';

class MySignupForm extends StatelessWidget {
  const MySignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name (First + Last Name)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) => MyValidator.validateRequiredField(value,
                      fieldName: MyTexts.firstName),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: MyTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: MySizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  validator: (value) => MyValidator.validateRequiredField(value,
                      fieldName: MyTexts.lastName),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: MyTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // Username
          TextFormField(
            validator: (value) => MyValidator.validateRequiredField(value,
                fieldName: MyTexts.username),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
              labelText: MyTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // Email
          TextFormField(
            validator: (value) => MyValidator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
              labelText: MyTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            validator: (value) => MyValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            expands: false,
            decoration: const InputDecoration(
              labelText: MyTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              validator: (value) => MyValidator.validatePassword(value),
              controller: controller.password,
              expands: false,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: MyTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),

          // Terms and Condition
          const MyTermsAndCondition(),
          const SizedBox(height: MySizes.spaceBtwSections),

          // Sign Up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(MyTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
