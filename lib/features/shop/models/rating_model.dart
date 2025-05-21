import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String id;
  final DocumentReference skuId; // Chuyển thành DocumentReference
  final DocumentReference userId; // Chuyển thành DocumentReference
  final int star;
  final DateTime createdAt;
  final DateTime updatedAt;

  RatingModel({
    required this.id,
    required this.skuId,
    required this.userId,
    required this.star,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RatingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return RatingModel(
      id: doc.id,
      skuId: data['skuId'] as DocumentReference,
      userId: data['userId'] as DocumentReference,
      star: data['star'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skuId': skuId,
      'userId': userId,
      'star': star,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
