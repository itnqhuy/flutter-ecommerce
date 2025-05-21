import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/shop/controllers/cart_controller.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/formatters/fomatter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title:
            Text('Giỏ hàng', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: const MyCartItems(),
      ),

      /// Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Obx(() {
          final total = cartController.totalCartPrice.value;
          return total == 0
              ? const SizedBox.shrink()
              : ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child:
                      Text('Thanh toán ${MyFormatter.formatCurrency(total)}'),
                );
        }),
      ),
    );
  }
}
