import 'package:cloud_firestore/cloud_firestore.dart';

class ShippingInfo {
  final String id;
  final String name;
  final String phone;
  final String provinceOrCity;
  final String district;
  final String ward;
  final String detailAddress;
  final bool isDefault;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ShippingInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.provinceOrCity,
    required this.district,
    required this.ward,
    required this.detailAddress,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert ShippingInfo to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'provinceOrCity': provinceOrCity,
      'district': district,
      'ward': ward,
      'detailAddress': detailAddress,
      'isDefault': isDefault,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Factory method to create a ShippingInfo from Firestore document snapshot
  factory ShippingInfo.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ShippingInfo(
      id: document.id,
      name: data['name'] ?? "",
      phone: data['phone'] ?? "",
      provinceOrCity: data['provinceOrCity'] ?? "",
      district: data['district'] ?? "",
      ward: data['ward'] ?? "",
      detailAddress: data['detailAddress'] ?? "",
      isDefault: data['isDefault'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }
}
