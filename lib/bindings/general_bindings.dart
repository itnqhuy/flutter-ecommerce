<<<<<<< HEAD
import '../features/shop/controllers/cart_controller.dart';
import '../features/shop/controllers/category_controller.dart';
=======
import '../features/shop/controllers/product/cart_controller.dart';
import '../features/shop/controllers/category_controller.dart';
import '../features/shop/controllers/product/check_out_controller.dart';
import '../features/shop/controllers/shippinginfo/shipping_info_controller.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import '/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CategoryController());
    Get.put(CartController());
<<<<<<< HEAD
=======
    Get.put(AddressController());
    Get.put(CheckOutController());
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  }
}
