import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/common/widgets/icons/my_circular_icon.dart';
import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/my_rounded_image.dart';
<<<<<<< HEAD
=======
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import '../../../../../common/widgets/products/favorite_icon/favorite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/images_controller.dart';
import '../../../models/product_model.dart';

class MyProductImageSlider extends StatefulWidget {
  const MyProductImageSlider({super.key, required this.product});
  final ProductModel product;

  @override
  State<MyProductImageSlider> createState() => _MyProductImageSliderState();
}

class _MyProductImageSliderState extends State<MyProductImageSlider> {
  late final ImagesController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(ImagesController(), tag: widget.product.id);

    controller.loadImages(widget.product);
  }

  @override
  void dispose() {
    Get.delete<ImagesController>(tag: widget.product.id);
    super.dispose();
  }
import 'package:iconsax/iconsax.dart';

class MyProductImageSlider extends StatelessWidget {
  const MyProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? MyColors.darkerGrey : MyColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(MySizes.productImageRadius * 2),
                child: Center(
                    child: Image(image: AssetImage(MyImages.productImage1))),
              ),
            ),

            //Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: MySizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: MySizes.spaceBtwItems),
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => MyRoundedImage(
                    width: 80,
                    backgroundColor: dark ? MyColors.dark : MyColors.white,
                    border: Border.all(color: MyColors.primary),
                    padding: const EdgeInsets.all(MySizes.sm),
                    imageUrl: MyImages.productImage10,
                  ),
                ),
              ),
            ),

            // AppBar icons
            MyAppBar(
              showBackArrow: true,
              actions: [
                MyFavoriteIcon(productId: widget.product.id),
<<<<<<< HEAD
=======
                MyCartCounterIcon(
                    iconColor: dark ? MyColors.white : MyColors.black),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
              ],
            ),
              actions: [MyCircularIcon(icon: Iconsax.heart, color: Colors.red)],
            )
          ],
        ),
      ),
    );
  }
}
