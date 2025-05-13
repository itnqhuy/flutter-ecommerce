import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyBillingPaymentSection extends StatelessWidget {
  const MyBillingPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        MySectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        Row(
          children: [
            MyRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? MyColors.light : MyColors.white,
              padding: const EdgeInsets.all(MySizes.sm),
              child: const Image(
                image: AssetImage(MyImages.paypal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: MySizes.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
