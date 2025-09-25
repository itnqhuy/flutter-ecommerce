import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/cart_item_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'shipping_info.dart';

class OrderModel {
  final String id;
  final DocumentReference userId;
  final OrderStatus status;
  final int totalPrice;
  final String payMethod;
  final Timestamp? payTime;
  final Timestamp? shippingTime;
  final Timestamp? cancelledTime;
  final ShippingInfoModel shippingInfo;
  final DocumentReference? couponCode;
  final int? pointUsed;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalPrice,
    required this.payMethod,
    required this.payTime,
    required this.items,
    required this.shippingTime,
    required this.cancelledTime,
    required this.shippingInfo,
    this.couponCode,
    this.pointUsed,
    required this.createdAt,
    required this.updatedAt,
  });

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Đã giao hàng'
      : status == OrderStatus.shipped
          ? 'Đang giao hàng'
          : 'Đang xử lý';

  /// Factory từ Firestore snapshot
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {}; // Kiểm tra dữ liệu không bị null

    return OrderModel(
      id: snapshot.id,
      userId: data['userId'] as DocumentReference,
      status: OrderStatus.values.firstWhere(
          (e) => e.toString() == 'OrderStatus.${data['status']}',
          orElse: () => OrderStatus.processing),
      totalPrice: data['totalPrice'] ?? 0,
      payMethod: data['payMethod'] ?? '',
      payTime: data['payTime'] as Timestamp?,
      shippingTime:
          data['shippingTime'] as Timestamp?, // Giữ nguyên null nếu chưa có
      cancelledTime:
          data['cancelledTime'] as Timestamp?, // Giữ nguyên null nếu chưa có
      shippingInfo: data['shippingInfo'] != null &&
              data['shippingInfo'] is Map<String, dynamic>
          ? ShippingInfoModel.fromJson(data['shippingInfo'])
          : ShippingInfoModel.empty(),
      couponCode: data['couponCode'] as DocumentReference?,
      pointUsed: data['pointUsed'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      items: (data['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }

  /// Chuyển về Map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'status': status.toString().split('.').last, // Lưu dưới dạng chuỗi
      'totalPrice': totalPrice,
      'payMethod': payMethod,
      'payTime': payTime,
      'shippingTime': shippingTime,
      'cancelledTime': cancelledTime,
      'shippingInfo': shippingInfo.toJson(),
      if (couponCode != null) 'couponCode': couponCode,
      'pointUsed': pointUsed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// copyWith hỗ trợ chỉnh sửa object
  OrderModel copyWith({
    String? id,
    DocumentReference? userId,
    OrderStatus? status,
    int? totalPrice,
    String? payMethod,
    Timestamp? payTime,
    Timestamp? shippingTime,
    Timestamp? cancelledTime,
    ShippingInfoModel? shippingInfo,
    DocumentReference? couponCode,
    int? pointUsed,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    List<CartItemModel>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      payMethod: payMethod ?? this.payMethod,
      payTime: payTime ?? this.payTime,
      shippingTime: shippingTime ?? this.shippingTime,
      cancelledTime: cancelledTime ?? this.cancelledTime,
      shippingInfo: shippingInfo ?? this.shippingInfo,
      couponCode: couponCode ?? this.couponCode,
      pointUsed: pointUsed ?? this.pointUsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }

  /// Object mặc định
  factory OrderModel.empty() => OrderModel(
        id: '',
        userId: FirebaseFirestore.instance.collection('Users').doc('none'),
        status: OrderStatus.processing,
        totalPrice: 0,
        payMethod: 'Thanh toán khi nhận hàng',
        payTime: Timestamp.now(),
        shippingTime: null,
        cancelledTime: null,
        shippingInfo: ShippingInfoModel.empty(),
        couponCode: null,
        pointUsed: 0,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        items: [],
      );
}
