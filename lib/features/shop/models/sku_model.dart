import 'package:cloud_firestore/cloud_firestore.dart';

class SkuModel {
  final String id;
<<<<<<< HEAD
  final String productId;
=======
  final DocumentReference productId;
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  final String code;
  final String imageUrl;
  final int cost;
  final int price;
  final int stock;
  final int minStock;
  final int maxStock;
  final bool status;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  SkuModel({
    required this.id,
    required this.productId,
    required this.code,
    required this.imageUrl,
    required this.cost,
    required this.price,
    required this.stock,
    required this.minStock,
    required this.maxStock,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  static SkuModel empty() => SkuModel(
        id: '',
<<<<<<< HEAD
        productId: '',
=======
        productId: FirebaseFirestore.instance
            .collection('Products')
            .doc(''), // Placeholder
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
        code: '',
        imageUrl: '',
        cost: 0,
        price: 0,
        stock: 0,
        minStock: 0,
        maxStock: 0,
        status: true,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory SkuModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return SkuModel.empty();

    return SkuModel(
      id: data['id'] ?? '',
<<<<<<< HEAD
      productId: data['productId'] ?? '',
=======
      productId: data['productId'] as DocumentReference,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      code: data['code'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      cost: data['cost'] ?? 0,
      price: data['price'] ?? 0,
      stock: data['stock'] ?? 0,
      minStock: data['minStock'] ?? 0,
      maxStock: data['maxStock'] ?? 0,
      status: data['status'] ?? true,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  factory SkuModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return SkuModel(
      id: doc.id,
<<<<<<< HEAD
      productId: data['productId'] ?? '',
=======
      productId: data['productId'] as DocumentReference,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      code: data['code'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      cost: data['cost'] ?? 0,
      price: data['price'] ?? 0,
      stock: data['stock'] ?? 0,
      minStock: data['minStock'] ?? 0,
      maxStock: data['maxStock'] ?? 0,
      status: data['status'] ?? true,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  toJson() {
    return {
      'id': id,
<<<<<<< HEAD
      'productId': productId,
=======
      'productId': productId, // Giữ nguyên DocumentReference
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      'code': code,
      'imageUrl': imageUrl,
      'cost': cost,
      'price': price,
      'stock': stock,
      'minStock': minStock,
      'maxStock': maxStock,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  SkuModel copyWith({
    String? id,
<<<<<<< HEAD
    String? productId,
=======
    DocumentReference? productId,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    String? code,
    String? imageUrl,
    int? cost,
    int? price,
    int? stock,
    int? minStock,
    int? maxStock,
    bool? status,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return SkuModel(
      id: id ?? this.id,
<<<<<<< HEAD
      productId: productId ?? this.productId,
=======
      productId:
          productId ?? this.productId, // Giữ nguyên kiểu DocumentReference
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      code: code ?? this.code,
      imageUrl: imageUrl ?? this.imageUrl,
      cost: cost ?? this.cost,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
