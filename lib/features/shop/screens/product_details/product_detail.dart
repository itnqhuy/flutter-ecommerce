import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';
import '../product_review/product_reviews.dart';
import 'widgets/bottom_add_to_cart_widgets.dart';
import 'widgets/product_attributes.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/product_meta_app.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Product slider
            MyProductImageSlider(product: product),

            //Product Details
            Padding(
              padding: EdgeInsets.only(
                  right: MySizes.defaultSpace,
                  left: MySizes.defaultSpace,
                  bottom: MySizes.defaultSpace),
              child: Column(
                children: [
                  //Rating and share
                  MyRatingAndShare(product: product),
                  //price, title,stock and brand
                  MyProductMetaData(product: product),
                  //Attributes
                  MyProductAttributes(),
                  const SizedBox(height: MySizes.spaceBtwSections),
                  //Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Thanh toán'))),
                  const SizedBox(height: MySizes.spaceBtwSections),
                  //Description
                  MySectionHeading(
                      title: 'Mô tả sản phẩm', showActionButton: false),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  ReadMoreText(
                    'Laptop là một thiết bị công nghệ không thể thiếu trong cuộc sống hiện đại, phục vụ cho nhiều mục đích như học tập, làm việc và giải trí. Với sự phát triển của công nghệ, laptop ngày càng trở nên mạnh mẽ, gọn nhẹ và dễ dàng mang theo bên mình. Các dòng laptop hiện nay được trang bị các cấu hình mạnh mẽ với bộ vi xử lý hiệu suất cao, bộ nhớ RAM lớn và ổ cứng SSD, giúp người dùng thực hiện các tác vụ nặng như thiết kế đồ họa, chỉnh sửa video, hay chơi game mượt mà',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Xem thêm',
                    trimExpandedText: 'Thu gọn',
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
                          title: 'Review (204)', showActionButton: false),
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
