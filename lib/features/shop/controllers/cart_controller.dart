import 'package:get/get.dart';
import 'package:ecommerce/utils/local_storage/storage_utility.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:ecommerce/data/repositories/SKUs/sku_repository.dart';
import 'package:ecommerce/features/shop/models/sku_model.dart';
import '../models/cart_item_model.dart';
import 'product/sku_attribute_controller.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Reactive Variables
  final RxInt noOfCartItems = 0.obs;
  final RxInt totalCartPrice = 0.obs;
  final RxInt productQuantityInCart = 0.obs;
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  /// SKU Attribute Controller
  final skuAttrController = Get.isRegistered<SkuAttributeController>()
      ? Get.find<SkuAttributeController>()
      : Get.put(SkuAttributeController());

  /// Add item to cart
  Future<void> addToCart(SkuModel sku) async {
    if (productQuantityInCart.value < 1) {
      MyLoaders.warningSnackBar(title: 'Chọn số lượng');
      return;
    }

    final selectedSku = skuAttrController.selectedSku.value;
    if (selectedSku == null || selectedSku.id.isEmpty) {
      MyLoaders.warningSnackBar(title: 'Vui lòng chọn phân loại');
      return;
    }

    if (selectedSku.stock < 1) {
      MyLoaders.warningSnackBar(
        title: 'Hết hàng',
        message: 'Phân loại này đã hết hàng',
      );
      return;
    }

    final newItem = await convertToCartItem(sku, productQuantityInCart.value);

    final index = cartItems.indexWhere((item) => item.skuId == newItem.skuId);

    if (index >= 0) {
      final updatedItem = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + newItem.quantity,
      );
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(newItem);
    }

    updateCart();
    productQuantityInCart.value = 0;
    productQuantityInCart.refresh();

    MyLoaders.successSnackBar(title: 'Đã thêm vào giỏ hàng');
  }

  Future<CartItemModel> convertToCartItem(SkuModel sku, int quantity) async {
    String? brandName = await SkuRepository.getBrandNameOfSku(sku.id);

    // imageUrl lấy thẳng từ sku
    String? imageUrl = sku.imageUrl;

    return CartItemModel(
      skuId: sku.id,
      quantity: quantity,
      title: sku.code,
      price: skuAttrController.finalPrice.value.toDouble(),
      image: imageUrl,
      brandName: brandName,
      selectedSKU: skuAttrController.selectedAttributes,
    );
  }

  /// Tính tổng tiền và số lượng
  void updateCartTotals() {
    noOfCartItems.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
    totalCartPrice.value = cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity).toInt());
  }

  /// Ghi dữ liệu giỏ hàng vào local
  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    MyLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  /// Load dữ liệu giỏ hàng từ local
  void loadCartItems() {
    final data = MyLocalStorage.instance().readData('cartItems');
    if (data != null) {
      final decoded = List<Map<String, dynamic>>.from(data);
      cartItems.assignAll(decoded.map((e) => CartItemModel.fromJson(e)));
      updateCartTotals();
    }
  }

  void increaseQuantity() {
    productQuantityInCart.value++;
  }

  void decreaseQuantity() {
    if (productQuantityInCart.value > 1) {
      productQuantityInCart.value--;
    }
  }

  /// Gộp update tổng và lưu local
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  /// Xoá SKU khỏi giỏ
  void removeItem(String skuId) {
    cartItems.removeWhere((item) => item.skuId == skuId);
    updateCart();
  }

  /// Xoá toàn bộ giỏ hàng
  void clearCart() {
    cartItems.clear();
    updateCart();
  }
}
