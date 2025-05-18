import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String imageUrl;
  String parentCate;
  bool isFeatured;
  Timestamp createdAt;
  Timestamp updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.parentCate,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty helper
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        imageUrl: '',
        parentCate: '',
        isFeatured: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  /// From Firestore
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final data = doc.data()!;
      return CategoryModel(
        id: doc.id,
        name: data['name'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        parentCate: data['parentCate'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        createdAt: data['createdAt'] ?? Timestamp.now(),
        updatedAt: data['updatedAt'] ?? Timestamp.now(),
      );
    } else {
      return CategoryModel.empty();
    }
  }

  /// To JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'parentCate': parentCate,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
