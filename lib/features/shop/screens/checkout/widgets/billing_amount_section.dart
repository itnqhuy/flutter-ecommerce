import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/formatters/fomatter.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

import '../../../controllers/product/cart_controller.dart';

class MyBillingAmountSection extends StatelessWidget {
  const MyBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        // SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng', style: Theme.of(context).textTheme.bodyMedium),
            Text(MyFormatter.formatCurrency(subTotal),
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí vận chuyển',
                style: Theme.of(context).textTheme.bodyMedium),
            Text(MyPricingCalculator.getShippingCost(),
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        //Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thuế', style: Theme.of(context).textTheme.bodyMedium),
            Text(MyPricingCalculator.calculateTax(subTotal),
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),

        //Order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng đơn hàng',
                style: Theme.of(context).textTheme.bodyMedium),
            Text(
                MyFormatter.formatCurrency(
                    MyPricingCalculator.calculateTotal(subTotal)),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
