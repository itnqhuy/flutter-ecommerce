import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String imageUrl;
  DocumentReference? parentCate; // Thay đổi thành DocumentReference
  bool isFeatured;
  Timestamp createdAt;
  Timestamp updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.parentCate, // Có thể null nếu không có danh mục cha
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty helper
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        imageUrl: '',
        parentCate: null, // Đặt null
        isFeatured: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  /// From Firestore
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      return CategoryModel.empty();
    }

    return CategoryModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      parentCate: data.containsKey('parentCate') &&
              data['parentCate'] is DocumentReference
          ? data['parentCate'] as DocumentReference
          : null,
      isFeatured: data['isFeatured'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  /// To JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'parentCate': parentCate?.path, // Chuyển DocumentReference thành string
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
