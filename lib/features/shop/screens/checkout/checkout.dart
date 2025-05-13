import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/cart/coupon_widget.dart';
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Order Review',
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
            onPressed: () => Get.to(() => SuccessScreen(
                  image: MyImages.successfulPaymentIcon,
                  title: 'Payment SUccess',
                  subtitle: 'Your item will be shipped soon!',
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                )),
            child: Text('Checkout \$256.0')),
      ),
    );
  }
}
