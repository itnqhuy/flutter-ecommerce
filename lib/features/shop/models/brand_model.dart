import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String id;
  final String name;
  final String imageUrl;
  final int sort;
  final bool isFeatured;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  BrandModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.sort,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory rỗng
  static BrandModel empty() => BrandModel(
        id: '',
        name: '',
        imageUrl: '',
        sort: 0,
        isFeatured: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  /// Tạo từ Firestore snapshot
  factory BrandModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      sort: data['sort'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  /// Tạo từ map (khi truyền thủ công)
  factory BrandModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      sort: data['sort'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  /// Gửi lên Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'sort': sort,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
