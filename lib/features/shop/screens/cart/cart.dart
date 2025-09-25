import 'package:ecommerce/common/widgets/appbar/appbar.dart';
<<<<<<< HEAD
import 'package:ecommerce/features/shop/controllers/cart_controller.dart';
=======
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: MyCartItems(),
      ),
      //checkout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Obx(() {
          final total = cartController.totalCartPrice.value;
<<<<<<< HEAD
          return ElevatedButton(
            onPressed:
                total > 0 ? () => Get.to(() => const CheckoutScreen()) : null,
            child: Text('Thanh toán ${MyFormatter.formatDecimalOnly(total)}'),
          );
=======
          return total == 0
              ? const SizedBox.shrink()
              : ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child:
                      Text('Thanh toán ${MyFormatter.formatCurrency(total)}'),
                );
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
        }),
      ),
    );
  }
}
