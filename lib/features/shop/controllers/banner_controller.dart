import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/banners/banner_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  /// Lấy danh sách banners từ Firestore
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final fetchedBanners = await bannerRepo.fetchBanners();

      banners.assignAll(fetchedBanners);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oops!!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
