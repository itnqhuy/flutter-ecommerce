import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAttributeModel {
  final String id;
  final DocumentReference productId;
  final String name;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ProductAttributeModel({
    this.id = '',
    required this.productId,
    this.name = '',
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  static ProductAttributeModel empty() => ProductAttributeModel(
        id: '',
        productId: FirebaseFirestore.instance.doc('Products/empty'),
        name: '',
      );

  factory ProductAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return ProductAttributeModel.empty();

    return ProductAttributeModel(
      id: data['id'] ?? '',
      productId: data['productId'] as DocumentReference,
      name: data['name'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  factory ProductAttributeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ProductAttributeModel(
      id: doc.id,
      productId: data['productId'] as DocumentReference,
      name: data['name'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
