import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rounded_container.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/formatters/fomatter.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final totalAmout = MyPricingCalculator.calculateTotal(subTotal);
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Chi tiết đơn hàng',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- Items in Cart
              MyCartItems(showAddRemoveButtons: false),
              SizedBox(height: MySizes.spaceBtwSections),

              //Coupon
              MyCouponCode(),
              const SizedBox(height: MySizes.spaceBtwSections),

              //Billing Sction
              MyRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(MySizes.md),
                backgroundColor: dark ? MyColors.black : MyColors.white,
                child: Column(
                  children: [
                    //Pricing
                    MyBillingAmountSection(),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    //Divider
                    const Divider(),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    //Payment
                    MyBillingPaymentSection(),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    //Addresss
                    MyBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //checkout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmout)
              : () => MyLoaders.warningSnackBar(
                  title: 'Giỏ hàng trống',
                  message: 'Thêm sản phẩm vào giỏ hàng để tiếp tục'),
          child: Text(
              'Thanh toán ${MyFormatter.formatCurrency(MyPricingCalculator.calculateTotal(subTotal))}'),
        ),
      ),
    );
  }
}
