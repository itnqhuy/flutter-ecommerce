import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/images/my_rounded_image.dart';
import 'package:ecommerce/features/shop/controllers/home_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

class MyPromoSlider extends StatelessWidget {
  const MyPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    if (banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        FlutterCarousel(
          options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              height: 200,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index)),
          items: banners.map((url) => MyRoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: MySizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(mainAxisSize: MainAxisSize.min, children: [
              for (int i = 0; i < banners.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 10),
                  backgroundColor: controller.carouslCurrentIndex.value == i
                      ? MyColors.primary
                      : MyColors.grey,
                )
            ]),
          ),
        ),
      ],
    );
  }
}
