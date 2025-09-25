import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String imageUrl;
<<<<<<< HEAD
  String parentCate;
=======
  String? thumbnail;
  DocumentReference? parentCate;
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  bool isFeatured;
  Timestamp createdAt;
  Timestamp updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
<<<<<<< HEAD
    required this.parentCate,
=======
    this.thumbnail,
    this.parentCate,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty helper
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        imageUrl: '',
<<<<<<< HEAD
        parentCate: '',
=======
        thumbnail: null,
        parentCate: null,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
        isFeatured: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  /// From Firestore
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
<<<<<<< HEAD
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
=======
    final data = doc.data();
    if (data == null) {
      return CategoryModel.empty();
    }

    return CategoryModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      thumbnail: data['thumbnail'],
      parentCate: data['parentCate'] is DocumentReference
          ? data['parentCate'] as DocumentReference
          : null,
      isFeatured: data['isFeatured'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  }

  /// To JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
<<<<<<< HEAD
      'parentCate': parentCate,
=======
      'thumbnail': thumbnail,
      'parentCate': parentCate?.path,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
