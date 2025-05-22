import 'package:cloud_firestore/cloud_firestore.dart';

class ShippingInfoModel {
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

  /// Tham chiếu đến User document (khóa ngoại)
  final DocumentReference userId;

  ShippingInfoModel({
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
    required this.userId,
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
      'userId': userId,
    };
  }

  ShippingInfoModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? provinceOrCity,
    String? district,
    String? ward,
    String? detailAddress,
    bool? isDefault,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    DocumentReference<Object?>? userId,
  }) {
    return ShippingInfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      provinceOrCity: provinceOrCity ?? this.provinceOrCity,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      detailAddress: detailAddress ?? this.detailAddress,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  // Factory method to create a ShippingInfo from Firestore document snapshot
  factory ShippingInfoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ShippingInfoModel(
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
      userId: data['userId'] as DocumentReference, // ép kiểu DocumentReference
    );
  }

  /// Tạo ShippingInfo rỗng
  static ShippingInfoModel empty() {
    return ShippingInfoModel(
      id: '',
      name: '',
      phone: '',
      provinceOrCity: '',
      district: '',
      ward: '',
      detailAddress: '',
      isDefault: false,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      userId: FirebaseFirestore.instance.collection('Users').doc('none'),
    );
  }
}
