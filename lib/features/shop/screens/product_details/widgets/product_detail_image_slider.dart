import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/my_rounded_image.dart';
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

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);

    return MyCurvedEdgeWidget(
      child: Container(
        color: dark ? MyColors.darkerGrey : MyColors.light,
        child: Stack(
          children: [
            /// Main Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(MySizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final imageUrl =
                        Get.find<ImagesController>(tag: widget.product.id)
                            .selectedImage
                            .value;

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              panEnabled: true,
                              minScale: 1.0,
                              maxScale: 4.0,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                progressIndicatorBuilder:
                                    (_, __, downloadProgress) =>
                                        CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: MyColors.primary,
                                ),
                                errorWidget: (_, url, error) =>
                                    const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: MyColors.primary,
                        ),
                        errorWidget: (_, url, error) =>
                            const Icon(Icons.broken_image),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Thumbnail Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: MySizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: Obx(() {
                  final images =
                      Get.find<ImagesController>(tag: widget.product.id)
                          .productImages;

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: MySizes.spaceBtwItems),
                    itemBuilder: (_, index) {
                      final img = images[index];
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
                  );
                }),
              ),
            ),

            /// AppBar
            MyAppBar(
              showBackArrow: true,
              actions: [
                MyFavoriteIcon(productId: widget.product.id),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
