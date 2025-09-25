<<<<<<< HEAD
import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/features/shop/controllers/cart_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
=======
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

class MyCartItems extends StatelessWidget {
  const MyCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    Future<bool?> showDeleteConfirmDialog() {
      return showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Xóa sản phẩm'),
          content: const Text(
              'Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Xóa'),
            ),
          ],
        ),
      );
    }

    return Obx(() {
      final items = cartController.cartItems;

      if (items.isEmpty) {
<<<<<<< HEAD
        return const Center(child: Text('Giỏ hàng của bạn đang trống.'));
=======
        return MyAnimationLoaderWidget(
          text: 'Giỏ hàng của bạn đang trống.',
          animation: MyImages.cartAnimation,
        );
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: MySizes.spaceBtwSections),
        itemBuilder: (_, index) {
          final item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyCartItem(item: item),
              if (showAddRemoveButtons)
                const SizedBox(height: MySizes.spaceBtwItems),

              /// Số lượng + Giá + Xóa
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Nút tăng giảm và xóa
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        MyProductQuanityWithAddRemoveButton(
                          quantity: item.quantity,
                          onAdd: () {
                            cartController.cartItems[index] =
                                item.copyWith(quantity: item.quantity + 1);
                            cartController.updateCart();
                          },
                          onRemove: () async {
                            if (item.quantity > 1) {
                              cartController.cartItems[index] =
                                  item.copyWith(quantity: item.quantity - 1);
                              cartController.updateCart();
                            } else {
                              final confirmed = await showDeleteConfirmDialog();
                              if (confirmed == true) {
                                cartController.removeItem(item.skuId);
                              }
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        // Nút xóa riêng biệt
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirmed = await showDeleteConfirmDialog();
                            if (confirmed == true) {
                              cartController.removeItem(item.skuId);
                            }
                          },
                        ),
                      ],
                    ),

                    /// Giá
                    MyProductPriceText(
                        price: (item.price * item.quantity).toInt()),
                  ],
                ),
            ],
          );
        },
      );
    });
  }
}
