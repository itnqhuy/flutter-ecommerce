import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Firebase instance
  final _db = FirebaseFirestore.instance;

  /// Lấy tất cả danh mục từ Firestore
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
<<<<<<< HEAD

      final categories =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();

      return categories;
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
=======
      final categories =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return categories;
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message ?? 'Lỗi Platform');
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải danh mục: $e');
    }
  }

<<<<<<< HEAD
  /// Lấy danh sách danh mục con theo parentCate
=======
  /// Lấy danh sách danh mục con theo `parentCateId`
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  Future<List<CategoryModel>> getSubCategories(String parentCateId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
<<<<<<< HEAD
          .where('parentCate', isEqualTo: parentCateId)
=======
          .where('parentCate',
              isEqualTo: _db
                  .collection('Categories')
                  .doc(parentCateId)) // Chuyển id thành DocumentReference
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
          .get();

      return snapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Không thể tải danh mục con: $e');
    }
  }

<<<<<<< HEAD
  /// Thêm danh mục mới
  Future<void> addCategory(CategoryModel category) async {
    try {
      await _db
          .collection('Categories')
          .doc(category.id)
          .set(category.toJson());
=======
  /// Thêm danh mục mới (Firestore tự động tạo ID nếu `id` rỗng)
  Future<void> addCategory(CategoryModel category) async {
    try {
      if (category.id.isEmpty) {
        await _db.collection('Categories').add(category.toJson());
      } else {
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    } catch (e) {
      throw Exception('Thêm danh mục thất bại: $e');
    }
  }

  /// Cập nhật danh mục
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _db
          .collection('Categories')
          .doc(category.id)
          .update(category.toJson());
    } catch (e) {
      throw Exception('Cập nhật danh mục thất bại: $e');
    }
  }

  /// Xóa danh mục
  Future<void> deleteCategory(String id) async {
    try {
      await _db.collection('Categories').doc(id).delete();
    } catch (e) {
      throw Exception('Xóa danh mục thất bại: $e');
    }
  }
}
