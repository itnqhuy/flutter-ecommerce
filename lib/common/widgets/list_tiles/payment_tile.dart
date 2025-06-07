import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/features/shop/controllers/product/check_out_controller.dart';
import 'package:ecommerce/features/shop/models/payment_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class MyPaymnetTile extends StatelessWidget {
  const MyPaymnetTile({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckOutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: MyRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: MyHelperFunctions.isDarkMode(context)
            ? MyColors.light
            : MyColors.white,
        padding: const EdgeInsets.all(MySizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
