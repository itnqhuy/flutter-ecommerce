import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class MyCartItems extends StatelessWidget {
  const MyCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) =>
          const SizedBox(height: MySizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          MyCartItem(),
          if (showAddRemoveButtons) SizedBox(height: MySizes.spaceBtwItems),
          //
          if (showAddRemoveButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 70),
                    //Add Remove Button
                    MyProductQuanityWithAddRemoveButton(),
                  ],
                ),
                MyProductPriceText(price: '256'),
              ],
            ),
        ],
      ),
    );
  }
}
