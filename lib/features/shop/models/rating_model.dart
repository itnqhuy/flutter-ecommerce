import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String id;
<<<<<<< HEAD
  final String skuId;
  final String userId;
  final int star;
=======
  final DocumentReference skuId;
  final DocumentReference userId;
  final int star;
  final String description;
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  final DateTime createdAt;
  final DateTime updatedAt;

  RatingModel({
    required this.id,
    required this.skuId,
    required this.userId,
    required this.star,
<<<<<<< HEAD
=======
    required this.description,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    required this.createdAt,
    required this.updatedAt,
  });

  factory RatingModel.fromFirestore(DocumentSnapshot doc) {
<<<<<<< HEAD
    final data = doc.data() as Map<String, dynamic>;

    return RatingModel(
      id: doc.id,
      skuId: (data['skuId'] as DocumentReference).id,
      userId: (data['userId'] as DocumentReference).id,
      star: data['star'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }
=======
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return RatingModel(
      id: doc.id,
      skuId: data['skuId'] as DocumentReference,
      userId: data['userId'] as DocumentReference,
      star: data['star'] ?? 0,
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skuId': skuId,
      'userId': userId,
      'star': star,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
}
