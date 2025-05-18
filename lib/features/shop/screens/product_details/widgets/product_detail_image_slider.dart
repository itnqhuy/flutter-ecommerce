import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/my_circular_icon.dart';
import '../../../../../common/widgets/images/my_rounded_image.dart';
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
  final controller = Get.put(ImagesController());

  @override
  void initState() {
    super.initState();
    controller.loadImages(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);

    return MyCurvedEdgeWidget(
      child: Container(
        color: dark ? MyColors.darkerGrey : MyColors.light,
        child: Stack(
          children: [
            // Main Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(MySizes.productImageRadius * 2),
                child: Center(
                  child: Obx(
                    () => CachedNetworkImage(
                      imageUrl: controller.selectedImage.value,
                      progressIndicatorBuilder: (_, __, downloadProgess) =>
                          CircularProgressIndicator(
                        value: downloadProgess.progress,
                        color: MyColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Thumbnail Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: MySizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: Obx(() => ListView.separated(
                      itemCount: controller.productImages.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: MySizes.spaceBtwItems),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        final img = controller.productImages[index];
                        return GestureDetector(
                          onTap: () => controller.selectImage(img),
                          child: MyRoundedImage(
                            width: 80,
                            imageUrl: img,
                            isNetworkImage: true,
                            border: Border.all(color: MyColors.primary),
                            padding: const EdgeInsets.all(MySizes.sm),
                            backgroundColor:
                                dark ? MyColors.dark : MyColors.white,
                          ),
                        );
                      },
                    )),
              ),
            ),

            // AppBar
            MyAppBar(
              showBackArrow: true,
              actions: const [
                MyCircularIcon(icon: Iconsax.heart, color: Colors.red)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
