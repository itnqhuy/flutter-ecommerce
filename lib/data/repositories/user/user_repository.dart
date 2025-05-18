import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/personalization/models/user_model.dart';
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
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Lấy thông tin người dùng thất bại. Vui lòng thử lại';
    }
  }

  // Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final snapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        throw UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Lấy thông tin người dùng thất bại. Vui lòng thử lại';
    }
  }

  // Function to update user data in Users Collection
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Cập nhật dữ liệu người dùng thất bại. Vui lòng thử lại';
    }
  }

  // Function to update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Cập nhật dữ liệu người dùng thất bại. Vui lòng thử lại';
    }
  }

  // Function to remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException catch (_) {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Xóa người dùng không thành công. Vui lòng thử lại';
    }
  }

  // Upload image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);

      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      return url;
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on FormatException {
      throw const MyFormatException();
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại sau.';
    }
  }
}
