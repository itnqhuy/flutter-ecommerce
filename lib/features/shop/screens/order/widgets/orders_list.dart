import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/styles/rounded_container.dart';
import '../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_function.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/order_controller.dart';
import '../../../models/order_model.dart';

class MyOrderListItems extends StatelessWidget {
  const MyOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());

    return FutureBuilder<List<OrderModel>>(
      future: controller.fetchUserOrder(),
      builder: (_, snapshot) {
        final emptyWidget = MyAnimationLoaderWidget(
          text: 'Không có lịch sử đơn hàng',
          animation: MyImages.loveAnimation,
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        final response =
            MyCloudHelperFunction.checkMultiRecorState(snapshot: snapshot);
        if (response != null) return response;

        final orders = snapshot.data ?? [];
        if (orders.isEmpty) return emptyWidget;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: MySizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];

            return MyRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(MySizes.md),
              backgroundColor: dark ? MyColors.dark : MyColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Row 1 - Status & Date
                  Row(
                    children: [
                      // Icon
                      const Icon(Iconsax.ship),
                      SizedBox(width: MySizes.spaceBtwItems / 2),

                      // Status & Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                      color: MyColors.primary,
                                      fontWeightDelta: 1),
                            ),
                            Text(
                              order.createdAt.toDate().toLocal().toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),

                      // Icon Button
                      IconButton(
                        onPressed: () {}, // Thêm hành động nếu cần
                        icon: const Icon(
                          Iconsax.arrow_right_4,
                          size: MySizes.iconSm,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  /// Row 2 - Order ID & Shipping Date
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // Icon
                            const Icon(Iconsax.tag),
                            SizedBox(width: MySizes.spaceBtwItems / 2),

                            // Order ID
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mã đơn hàng',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    '[#${order.id}]',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // Icon
                            const Icon(Iconsax.calendar),
                            SizedBox(width: MySizes.spaceBtwItems / 2),

                            // Shipping Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ngày giao hàng',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.shippingTime > 0
                                        ? DateTime.fromMillisecondsSinceEpoch(
                                                order.shippingTime)
                                            .toLocal()
                                            .toString()
                                        : 'Chưa có ngày giao hàng',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
