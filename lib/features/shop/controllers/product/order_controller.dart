import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/check_out_controller.dart';
import 'package:ecommerce/features/shop/controllers/shippinginfo/shipping_info_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/orders/order_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckOutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrder() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      MyLoaders.warningSnackBar(title: 'Oops!', message: e.toString());
      return [];
    }
  }

  void processOrder(int totalAmount,
      {DocumentReference? couponCode, int? loyaltyPointsUsed}) async {
    try {
      MyFullScreenLoader.openLoadingDialog(
          'Đang xử lý đơn hàng của bạn', MyImages.pencilAnimation);

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null || userId.isEmpty) {
        throw 'Không thể tìm thấy thông tin người dùng';
      }

      // Chuyển đổi `userId` thành `DocumentReference`
      final userRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      // Áp dụng giảm giá từ coupon hoặc loyalty points
      final int discountedPrice =
          await applyDiscounts(totalAmount, couponCode, loyaltyPointsUsed);

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userRef,
        status: OrderStatus.processing,
        totalPrice: discountedPrice.toInt(),
        payMethod: checkoutController.selectedPaymentMethod.value.name,
        shippingInfo: addressController.selectedAddress.value,
        shippingTime: null,
        cancelledTime: null,
        payTime: null,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        items: cartController.cartItems.map((item) => item).toList(),
        couponCode: couponCode,
        pointUsed: loyaltyPointsUsed ?? 0,
      );

      // Lưu đơn hàng vào Firestore
      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(
        () => SuccessScreen(
          image: MyImages.staticSuccessIllustration,
          title: 'Thanh toán thành công',
          subTitle: 'Đơn hàng của bạn sẽ sớm được giao',
          onPressed: () => Get.offAll(
            () => const NavigationMenu(),
          ),
        ),
      );
    } catch (e) {
      MyFullScreenLoader.stopLoading();
      MyLoaders.warningSnackBar(title: 'Lỗi', message: e.toString());
    }
  }

  /// Hàm xử lý giảm giá từ coupon và loyalty points
  Future<int> applyDiscounts(int totalAmount, DocumentReference? couponCode,
      int? loyaltyPointsUsed) async {
    int discountedTotal = totalAmount;

    // Kiểm tra và áp dụng coupon
    if (couponCode != null) {
      final couponSnapshot = await couponCode.get();
      if (couponSnapshot.exists) {
        final discountValue = couponSnapshot['value'] ?? 0;
        discountedTotal = (totalAmount - discountValue).toInt();
      }
    }

    // Kiểm tra và áp dụng loyalty points
    if (loyaltyPointsUsed != null && loyaltyPointsUsed > 0) {
      final pointsValue =
          loyaltyPointsUsed * 1000; // Giả định 1 điểm = 1000 VND
      discountedTotal -= pointsValue;
    }

    return discountedTotal > 0 ? discountedTotal : 0; // Tránh giá trị âm
  }
}
