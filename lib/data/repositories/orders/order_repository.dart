import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/shop/models/order_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Lấy danh sách đơn hàng của người dùng
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null || userId.isEmpty) {
        throw 'Không thể tìm thông tin người dùng.';
      }

      final userRef = _db.collection('Users').doc(userId);
      final snapshot = await _db
          .collection('Orders')
          .where('userId', isEqualTo: userRef)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw 'Có lỗi khi tải danh sách đơn hàng: $e';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      if (userId.isEmpty) {
        throw 'User ID không hợp lệ!';
      }

      // Tạo tham chiếu đến collection 'Orders'
      final orderRef = _db.collection('Orders');

      // Nếu `order.id` chưa có, tạo mới bằng Firebase
      if (order.id.isEmpty) {
        await orderRef.add(order.toJson());
      } else {
        await orderRef.doc(order.id).set(order.toJson());
      }
    } catch (e) {
      throw 'Không thể lưu đơn hàng: $e';
    }
  }
}
