import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Thay đổi tên',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'Sử dụng tên thật để xác minh dễ dàng. Tên này sẽ xuất hiện ở nhiều trang.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  // First Name
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => MyValidator.validateRequiredField(
                        value,
                        fieldName: 'Họ'),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: MyTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwInputFields),

                  // Last Name
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => MyValidator.validateRequiredField(
                        value,
                        fieldName: 'Tên'),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: MyTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: MySizes.spaceBtwInputFields),

                  // Save
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.updateUserName(),
                      child: const Text('Lưu'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
