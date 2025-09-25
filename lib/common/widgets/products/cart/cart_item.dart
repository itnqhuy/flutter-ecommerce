import 'package:flutter/material.dart';
import '../../../../features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/my_rounded_image.dart';
import '../../texts/my_brand_title_text_verified_icon.dart';
import '../../texts/product_title_text.dart';

class MyCartItem extends StatelessWidget {
  const MyCartItem({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Hình ảnh sản phẩm
        MyRoundedImage(
          imageUrl: item.image ?? '',
          isNetworkImage: true,
<<<<<<< HEAD
          width: 60,
          height: 60,
=======
          width: 80,
          height: 80,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
          padding: const EdgeInsets.all(MySizes.sm),
          backgroundColor: isDark ? MyColors.darkerGrey : MyColors.light,
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        /// Thông tin sản phẩm
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.brandName != null)
                MyBrandTitleWithVerifiedIcon(title: item.brandName!),
              Flexible(
                child: MyProductTitleText(
                  title: item.title,
                  maxLines: 1,
                ),
              ),

              /// Thuộc tính đã chọn
              if (item.selectedSKU != null && item.selectedSKU!.isNotEmpty)
                Text.rich(
                  TextSpan(
                    children: item.selectedSKU!.entries
                        .expand((entry) => [
                              TextSpan(
                                text: '${entry.key}: ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: '${entry.value}   ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ])
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
