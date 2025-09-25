import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  final String id;
  final DocumentReference skuId;
  final int discountPercent;
  final Timestamp start;
  final Timestamp end;
  final int maxUsage;
  final int usedCount;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const PromotionModel({
    required this.id,
    required this.skuId,
    required this.discountPercent,
    required this.start,
    required this.end,
    required this.maxUsage,
    required this.usedCount,
    required this.createdAt,
    required this.updatedAt,
  });

  static PromotionModel empty() => PromotionModel(
        id: '',
        skuId: FirebaseFirestore.instance.doc('/SKUs/none'),
        discountPercent: 0,
        start: Timestamp.now(),
        end: Timestamp.now(),
        maxUsage: 0,
        usedCount: 0,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory PromotionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) return PromotionModel.empty();

    return PromotionModel(
      id: doc.id,
      skuId: data['skuId'] as DocumentReference,
      discountPercent: data['discountPercent'] ?? 0,
      start: data['start'] ?? Timestamp.now(),
      end: data['end'] ?? Timestamp.now(),
      maxUsage: data['maxUsage'] ?? 0,
      usedCount: data['usedCount'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  /// Ghi về Firestore
  Map<String, dynamic> toJson() {
    return {
      'skuId': skuId,
      'discountPercent': discountPercent,
      'start': start,
      'end': end,
      'maxUsage': maxUsage,
      'usedCount': usedCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
