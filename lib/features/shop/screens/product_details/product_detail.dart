<<<<<<< HEAD
<<<<<<< HEAD
=======
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
=======
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
>>>>>>> parent of 450796a (restore all)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

<<<<<<< HEAD
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
<<<<<<< HEAD
=======
import '../../controllers/product/cart_controller.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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
=======
class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});
>>>>>>> parent of 450796a (restore all)

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    ProductController.instance.loadProductRatings(product.id);
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
<<<<<<< HEAD
                      width: double.infinity,
                      child: ElevatedButton(
<<<<<<< HEAD
                          onPressed: () {}, child: Text('Mua ngay'))),
=======
                    width: double.infinity,
                    child: Obx(() {
                      final sku =
                          SkuAttributeController.instance.selectedSku.value;
                      final skuAttriController =
                          SkuAttributeController.instance;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: sku == null || sku.id.isEmpty
                              ? null
                              : () async {
                                  if (!(await skuAttriController
                                      .isSelectionComplete())) {
                                    Get.snackbar(
                                      'Chưa đầy đủ phân loại',
                                      'Hãy chọn đầy đủ phân loại nhé',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                    return; // Ngăn việc tiếp tục xử lý giỏ hàng nếu chưa đủ phân loại
                                  }
                                  cartController.addToCart(sku);
                                  Get.to(() => const CheckoutScreen());
                                },
                          child: Text('Mua ngay'),
                        ),
                      );
                    }),
                  ),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
=======
                          onPressed: () {}, child: Text('Checkout'))),
>>>>>>> parent of 450796a (restore all)
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
