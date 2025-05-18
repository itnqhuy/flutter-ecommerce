import 'package:cloud_firestore/cloud_firestore.dart';

class SkuAttributeModel {
  final String attributeId;
  final String value;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  SkuAttributeModel({
    required this.attributeId,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  static SkuAttributeModel empty() => SkuAttributeModel(
        attributeId: "",
        value: "",
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  factory SkuAttributeModel.fromJson(Map<String, dynamic> doc) {
    final data = doc;
    if (data.isEmpty) return SkuAttributeModel.empty();
    return SkuAttributeModel(
      attributeId: data['attributeId'] ?? '',
      value: data['value'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributeId': attributeId,
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
