import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/SKUs/sku_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  final RxString selectedImage = ''.obs;
  final RxList<String> productImages = <String>[].obs;

  /// Load ảnh từ sản phẩm và các SKU
  Future<void> loadImages(ProductModel product) async {
    final images = <String>[];

    images.addAll(product.imagesUrl.where((url) => url.trim().isNotEmpty));

    final skus = await SkuRepository.getAllSkusByProductId(product.id);
    for (var sku in skus) {
      if (sku.imageUrl.trim().isNotEmpty) {
        images.add(sku.imageUrl);
      }
    }

    productImages.assignAll(images);
    selectedImage.value = images.isNotEmpty ? images.first : '';
  }

  void selectImage(String image) => selectedImage.value = image;

  void showEnlargedImage(String imageUrl) {
    Get.to(
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: MySizes.defaultSpace * 2,
                horizontal: MySizes.defaultSpace,
              ),
              child: _buildNetworkImage(imageUrl, enlarged: true),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text('Đóng'),
              ),
            ),
          ],
        ),
      ),
      fullscreenDialog: true,
    );
  }

  Widget buildImage(String url,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    return _buildNetworkImage(url, width: width, height: height, fit: fit);
  }

  Widget _buildNetworkImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    bool enlarged = false,
  }) {
    if (url.isEmpty) {
      Get.snackbar('Lỗi ảnh', 'Không có đường dẫn ảnh.',
          snackPosition: SnackPosition.BOTTOM);
      return const Icon(Icons.broken_image, size: 40);
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      progressIndicatorBuilder: (_, __, progress) =>
          CircularProgressIndicator(value: progress.progress),
      errorWidget: (_, failedUrl, error) {
        Get.snackbar(
          'Lỗi khi tải ảnh',
          'Không thể tải ảnh: $failedUrl',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
        return Icon(
          Icons.broken_image,
          size: enlarged ? 80 : 40,
          color: Colors.grey,
        );
      },
    );
  }
}
