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
        skuId: FirebaseFirestore.instance.collection('SKUs').doc(),
        attributeId:
            FirebaseFirestore.instance.collection('ProductAttribute').doc(),
        value: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory SkuAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return SkuAttributeModel.empty();

    return SkuAttributeModel(
      skuId: data['SKUId'] is String
          ? FirebaseFirestore.instance.collection('SKUs').doc(data['SKUId'])
          : data['SKUId'] as DocumentReference? ??
              FirebaseFirestore.instance.collection('SKUs').doc(),
      attributeId: data['attributeId'] is String
          ? FirebaseFirestore.instance
              .collection('ProductAttribute')
              .doc(data['attributeId'])
          : data['attributeId'] as DocumentReference? ??
              FirebaseFirestore.instance.collection('ProductAttribute').doc(),
      value: data['value'] ?? '',
      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
      updatedAt: data['updatedAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  factory SkuAttributeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return SkuAttributeModel(
      skuId: data['SKUId'] is String
          ? FirebaseFirestore.instance.collection('SKUs').doc(data['SKUId'])
          : data['SKUId'] as DocumentReference? ??
              FirebaseFirestore.instance.collection('SKUs').doc(),
      attributeId: data['attributeId'] is String
          ? FirebaseFirestore.instance
              .collection('ProductAttribute')
              .doc(data['attributeId'])
          : data['attributeId'] as DocumentReference? ??
              FirebaseFirestore.instance.collection('ProductAttribute').doc(),
      value: data['value'] ?? '',
      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
      updatedAt: data['updatedAt'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SKUId': skuId,
      'attributeId': attributeId,
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  SkuAttributeModel copyWith({
    DocumentReference? skuId,
    DocumentReference? attributeId,
    String? value,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return SkuAttributeModel(
      skuId: skuId ?? this.skuId,
      attributeId: attributeId ?? this.attributeId,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
