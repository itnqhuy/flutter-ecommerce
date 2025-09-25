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
<<<<<<< HEAD
        skuId: FirebaseFirestore.instance.doc('SKUs/empty'),
        attributeId: FirebaseFirestore.instance.doc('ProductAttributes/empty'),
=======
        skuId: FirebaseFirestore.instance.collection('SKUs').doc(),
        attributeId:
            FirebaseFirestore.instance.collection('ProductAttribute').doc(),
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
        value: '',
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory SkuAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return SkuAttributeModel.empty();

    return SkuAttributeModel(
<<<<<<< HEAD
      skuId: data['skuId'] as DocumentReference,
      attributeId: data['attributeId'] as DocumentReference,
      value: data['value'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
=======
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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    );
  }

  factory SkuAttributeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return SkuAttributeModel(
<<<<<<< HEAD
      skuId: data['skuId'] as DocumentReference,
      attributeId: data['attributeId'] as DocumentReference,
      value: data['value'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
=======
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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    );
  }

  Map<String, dynamic> toJson() {
    return {
<<<<<<< HEAD
      'skuId': skuId,
=======
      'SKUId': skuId,
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      'attributeId': attributeId,
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
<<<<<<< HEAD
=======

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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
}
