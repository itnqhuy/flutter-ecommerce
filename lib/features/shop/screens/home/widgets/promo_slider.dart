import 'package:ecommerce/common/widgets/animations/shimmer_effect.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

import '../../../controllers/banner_controller.dart';

class MyPromoSlider extends StatelessWidget {
  const MyPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const MyShimmerEffect(width: double.infinity, height: 190);
      }

      if (controller.banners.isEmpty) {
        return const Center(
          child: Text("Không có dữ liệu"),
        );
      } else {
        return Column(
          children: [
            FlutterCarousel(
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                height: 145,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
                showIndicator: false,
              ),
              items: controller.banners
                  .map((banner) => MyRoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        borderRadius: 10,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ))
                  .toList(),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),
            Center(
              child: Obx(
                () => Row(mainAxisSize: MainAxisSize.min, children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    MyCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carouselCurrentIndex.value == i
                              ? MyColors.primary
                              : MyColors.grey,
                    )
                ]),
              ),
            ),
          ],
        );
      }
    });
  }
}
