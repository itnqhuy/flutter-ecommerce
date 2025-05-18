import 'package:cloud_firestore/cloud_firestore.dart';

class SkuModel {
  final String id;
  final String productId;
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
        productId: '',
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
      productId: data['productId'] ?? '',
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
      productId: data['productId'] ?? '',
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
      'productId': productId,
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
    String? productId,
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
      productId: productId ?? this.productId,
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
