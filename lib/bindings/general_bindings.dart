import '../features/shop/controllers/cart_controller.dart';
import '../features/shop/controllers/category_controller.dart';
import '/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CategoryController());
    Get.put(CartController());
  }
}
