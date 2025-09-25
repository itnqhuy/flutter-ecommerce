import 'package:cloud_firestore/cloud_firestore.dart';

class SkuAttributeModel {
  final DocumentReference skuId;
  final DocumentReference attributeId;
  final String value;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  SkuAttributeModel({
    required this.skuId,
    required this.attributeId,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  static SkuAttributeModel empty() => SkuAttributeModel(
        skuId: FirebaseFirestore.instance.doc('SKUs/empty'),
        attributeId: FirebaseFirestore.instance.doc('ProductAttributes/empty'),
        value: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory SkuAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return SkuAttributeModel.empty();

    return SkuAttributeModel(
      skuId: data['skuId'] as DocumentReference,
      attributeId: data['attributeId'] as DocumentReference,
      value: data['value'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  factory SkuAttributeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return SkuAttributeModel(
      skuId: data['skuId'] as DocumentReference,
      attributeId: data['attributeId'] as DocumentReference,
      value: data['value'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skuId': skuId,
      'attributeId': attributeId,
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
