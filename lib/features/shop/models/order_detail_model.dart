import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailModel {
  final String id;
  final DocumentReference orderRef; // Tham chiếu đến Order
  final DocumentReference skulRef; // Tham chiếu đến SKU
  final int quantity;
  final int price;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  OrderDetailModel({
    required this.id,
    required this.orderRef,
    required this.skulRef,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Tạo OrderDetailModel từ Firestore DocumentSnapshot
  factory OrderDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() ?? {};
    return OrderDetailModel(
      id: snapshot.id,
      orderRef: data['orderRef'] as DocumentReference,
      skulRef: data['skulRef'] as DocumentReference,
      quantity: data['quantity'] ?? 0,
      price: data['price'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  /// Chuyển đối tượng thành JSON để lưu vào Firestore
  Map<String, dynamic> toJson() {
    return {
      'orderRef': orderRef,
      'skulRef': skulRef,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Tạo một bản sao của OrderDetailModel với các giá trị mới
  OrderDetailModel copyWith({
    String? id,
    DocumentReference? orderRef,
    DocumentReference? skulRef,
    int? quantity,
    int? price,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return OrderDetailModel(
      id: id ?? this.id,
      orderRef: orderRef ?? this.orderRef,
      skulRef: skulRef ?? this.skulRef,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Tạo một OrderDetailModel trống
  static OrderDetailModel empty() {
    return OrderDetailModel(
      id: '',
      orderRef: FirebaseFirestore.instance.collection('Orders').doc('none'),
      skulRef: FirebaseFirestore.instance.collection('SKUs').doc('none'),
      quantity: 0,
      price: 0,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }
}
