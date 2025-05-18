import 'package:cloud_firestore/cloud_firestore.dart';

class SkuModel {
  final String id;
  final String productId;
  final String name;
  final String imagesUrl;
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
    required this.name,
    required this.imagesUrl,
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
        name: '',
        imagesUrl: '',
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
      name: data['name'] ?? '',
      imagesUrl: data['imagesUrl'] ?? '',
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
      'name': name,
      'imagesUrl': imagesUrl,
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
    String? name,
    String? imagesUrl,
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
      name: name ?? this.name,
      imagesUrl: imagesUrl ?? this.imagesUrl,
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
