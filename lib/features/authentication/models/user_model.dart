import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/fomatter.dart';
import '../../shop/models/shipping_info.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String? avatarUrl;
  final String role;
  final List<ShippingInfo>? shippingInfo;
  final bool isBanned;
  final int loyaltyPoints;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.avatarUrl,
    required this.role,
    this.shippingInfo,
    required this.isBanned,
    required this.loyaltyPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Helper function to get the full name (first + last)
  String get fullNameWithSpaces => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo =>
      MyFormatter.formatVietnamPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(
        id: "",
        firstName: "",
        lastName: "",
        username: "",
        email: "",
        phoneNumber: "",
        avatarUrl: "",
        role: "",
        shippingInfo: null,
        isBanned: false,
        loyaltyPoints: 0,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

  // Convert UserModel to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'role': role,
      'shippingInfo': shippingInfo?.map((s) => s.toJson()).toList(),
      'isBanned': isBanned,
      'loyaltyPoints': loyaltyPoints,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Factory method to create a UserModel from Firestore document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    var shippingInfoList = (data['shippingInfo'] as List<dynamic>?)
        ?.map((s) => ShippingInfo.fromSnapshot(s))
        .toList();

    return UserModel(
      id: document.id,
      firstName: data['firstName'] ?? "",
      lastName: data['lastName'] ?? "",
      username: data['username'] ?? "",
      email: data['email'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      avatarUrl: data['avatarUrl'] ?? "",
      role: data['role'] ?? "",
      shippingInfo: shippingInfoList,
      isBanned: data['isBanned'] ?? false,
      loyaltyPoints: data['loyaltyPoints'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }
}
