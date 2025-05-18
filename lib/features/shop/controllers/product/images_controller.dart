import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/SKUs/sku_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  RxString selectedImage = ''.obs;
  RxList<String> productImages = <String>[].obs;

  Future<void> loadImages(ProductModel product) async {
    final images = <String>[];

    images.addAll(product.imagesUrl);

    final skus = await SkuRepository.getAllSkusByProductId(product.id);
    for (var sku in skus) {
      if (sku.imagesUrl.isNotEmpty) {
        images.add(sku.imagesUrl);
      }
    }

    if (images.isNotEmpty) selectedImage.value = images.first;
    productImages.assignAll(images);
  }

  void selectImage(String image) => selectedImage.value = image;

  void showEnlargedImage(String image) {
    Get.to(
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ảnh phóng to
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: MySizes.defaultSpace * 2,
                horizontal: MySizes.defaultSpace,
              ),
              child: CachedNetworkImage(imageUrl: image),
            ),

            const SizedBox(height: MySizes.spaceBtwSections),

            // Nút đóng
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Đóng'),
                ),
              ),
            ),
          ],
        ),
      ),
      fullscreenDialog: true,
    );
  }
}
