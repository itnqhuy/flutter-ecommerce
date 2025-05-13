import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/bottom_add_to_cart_widgets.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_meta_app.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce/features/shop/screens/product_review/product_reviews.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: MyBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Product slider
            MyProductImageSlider(),

            //Product Details
            Padding(
              padding: EdgeInsets.only(
                  right: MySizes.defaultSpace,
                  left: MySizes.defaultSpace,
                  bottom: MySizes.defaultSpace),
              child: Column(
                children: [
                  //Rating and share
                  MyRatingAndShare(),
                  //price, title,stock and brand
                  MyProductMetaData(),
                  //Attributes
                  MyProductAttributes(),
                  const SizedBox(height: MySizes.spaceBtwSections),
                  //Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Checkout'))),
                  const SizedBox(height: MySizes.spaceBtwSections),
                  //Description
                  MySectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  ReadMoreText(
                    'Laptop là một thiết bị công nghệ không thể thiếu trong cuộc sống hiện đại, phục vụ cho nhiều mục đích như học tập, làm việc và giải trí. Với sự phát triển của công nghệ, laptop ngày càng trở nên mạnh mẽ, gọn nhẹ và dễ dàng mang theo bên mình. Các dòng laptop hiện nay được trang bị các cấu hình mạnh mẽ với bộ vi xử lý hiệu suất cao, bộ nhớ RAM lớn và ổ cứng SSD, giúp người dùng thực hiện các tác vụ nặng như thiết kế đồ họa, chỉnh sửa video, hay chơi game mượt mà',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: MyColors.primary),
                    lessStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: MyColors.primary),
                  ),

                  //Review
                  Divider(),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MySectionHeading(
                          title: 'Review(204)', showActionButton: false),
                      IconButton(
                        icon: const Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        ),
                        onPressed: () =>
                            Get.to(() => const ProductReviewsScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
