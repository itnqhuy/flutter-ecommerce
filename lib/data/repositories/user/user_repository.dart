import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/authentication/models/user_model.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_format_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Có lỗi xảy ra. Vui lòng thử lại';
    }
  }

  // Function to fetch user details based on user ID.
  Future<UserModel> fetchUserById(String userId) async {
    try {
      final snapshot = await _db.collection("Users").doc(userId).get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        throw 'Không tìm thấy người dùng';
      }
    } catch (e) {
      throw 'Lấy thông tin người dùng thất bại. Vui lòng thử lại';
    }
  }

  // Function to update any field in specific Users Collection.
  Future<void> updateUserField(
      String userId, Map<String, dynamic> updatedFields) async {
    try {
      await _db.collection("Users").doc(userId).update(updatedFields);
    } catch (e) {
      throw 'Cập nhật dữ liệu người dùng thất bại. Vui lòng thử lại';
    }
  }
}
