import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String categoryId;
  final String brandId;
  final String name;
  final String description;
  final bool isFeatured;
  final String status;
  final List<String> imagesUrl;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.brandId,
    required this.name,
    required this.description,
    required this.status,
    required this.isFeatured,
    required this.imagesUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        categoryId: '',
        brandId: '',
        name: '',
        description: '',
        status: '',
        isFeatured: false,
        imagesUrl: [],
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() == null) return ProductModel.empty();
    final data = doc.data()!;
    return ProductModel(
      id: doc.id,
      categoryId: (data['idCategory'] as DocumentReference).id,
      brandId: (data['idBrand'] as DocumentReference).id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      status: data['status'] ?? '',
      imagesUrl: List<String>.from(data['imagesUrl'] ?? []),
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    if (data.isEmpty) return ProductModel.empty();

    return ProductModel(
      id: document.id,
      categoryId: (data['idCategory'] as DocumentReference).id,
      brandId: (data['idBrand'] as DocumentReference).id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      status: data['status'] ?? '',
      imagesUrl: List<String>.from(data['imagesUrl'] ?? []),
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  toJson() {
    return {
      'categoryId': categoryId,
      'brandId': brandId,
      'name': name,
      'description': description,
      'isFeatured': isFeatured,
      'status': status,
      'imagesUrl': imagesUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
