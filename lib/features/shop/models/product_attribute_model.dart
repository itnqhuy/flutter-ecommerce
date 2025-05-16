import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAttributeModel {
  final String id;
  final String productId;
  final String name;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ProductAttributeModel({
    this.id = '',
    this.productId = '',
    this.name = '',
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  static ProductAttributeModel empty() => ProductAttributeModel();

  factory ProductAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return ProductAttributeModel.empty();

    return ProductAttributeModel(
      id: data['id'] ?? '',
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
