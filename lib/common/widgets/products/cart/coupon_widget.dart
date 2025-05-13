import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyCouponCode extends StatelessWidget {
  const MyCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return MyRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? MyColors.dark : MyColors.white,
      padding: const EdgeInsets.only(
        top: MySizes.sm,
        bottom: MySizes.sm,
        right: MySizes.sm,
        left: MySizes.md,
      ),
      child: Row(
        children: [
          //Text Filed
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a coupon code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          //Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: dark
                      ? MyColors.white.withOpacity(0.5)
                      : MyColors.dark.withOpacity(0.5),
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  side: BorderSide(color: Colors.grey.withOpacity(0.1))),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
