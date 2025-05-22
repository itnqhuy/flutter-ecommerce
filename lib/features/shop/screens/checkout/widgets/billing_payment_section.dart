import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/styles/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/check_out_controller.dart';

class MyBillingPaymentSection extends StatelessWidget {
  const MyBillingPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CheckOutController.instance;
    final dark = MyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        MySectionHeading(
          title: 'Phương thức thanh toán',
          buttonTitle: 'Thay đổi',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              MyRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? MyColors.light : MyColors.white,
                padding: const EdgeInsets.all(MySizes.sm),
                child: Image(
                  image:
                      AssetImage(controller.selectedPaymentMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: MySizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
