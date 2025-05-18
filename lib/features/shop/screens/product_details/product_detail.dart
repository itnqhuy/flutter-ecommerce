import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/sku_attribute_controller.dart';
import '../../models/product_model.dart';
import '../product_review/product_reviews.dart';
import '../product_review/widgets/rating_progress_indicator.dart';
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
    final dark = MyHelperFunctions.isDarkMode(context);
    final dividerColor = dark ? Colors.grey.shade700 : Colors.grey.shade300;
    final iconColor = dark ? MyColors.white : MyColors.black;
    final textColor = dark ? MyColors.white : MyColors.black;

    return Scaffold(
      bottomNavigationBar: Obx(() {
        final sku = SkuAttributeController.instance.selectedSku.value;
        if (sku == null || sku.id.isEmpty) {
          return const SizedBox(); // hoặc show nút mờ
        }
        return MyBottomAddToCart(sku: sku);
      }),
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
                  const SizedBox(height: MySizes.spaceBtwItems),

                  //Attributes
                  MyProductAttributes(product: product),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  //Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Mua ngay'))),
                  const SizedBox(height: MySizes.spaceBtwSections),
                  //Description
                  MySectionHeading(
                      title: 'Mô tả sản phẩm', showActionButton: false),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  ReadMoreText(
                    product.description,
                    trimLines: 5,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Xem thêm',
                    trimExpandedText: ' Thu gọn',
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: MyColors.grey),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: MyColors.grey),
                  ),

                  // Overall Product Ratings
                  Divider(color: dividerColor),
                  MyOverallProductRating(product: product),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  //Review
                  Divider(color: dividerColor),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MySectionHeading(
                        title: 'Chia sẻ và đánh giá',
                        showActionButton: false,
                        textColor: textColor,
                      ),
                      IconButton(
                        icon: Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                          color: iconColor,
                        ),
                        onPressed: () => Get.to(
                            () => ProductReviewsScreen(product: product)),
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
