import '../features/shop/controllers/product/cart_controller.dart';
import '../features/shop/controllers/category_controller.dart';
import '../features/shop/controllers/product/check_out_controller.dart';
import '../features/shop/controllers/shippinginfo/shipping_info_controller.dart';
import '/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CategoryController());
    Get.put(CartController());
    Get.put(AddressController());
    Get.put(CheckOutController());
  }
}
