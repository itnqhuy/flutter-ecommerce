import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carouslCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carouslCurrentIndex.value = index;
  }
}
