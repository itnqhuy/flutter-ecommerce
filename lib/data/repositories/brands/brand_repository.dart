import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();

      return snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải thương hiệu: $e');
    }
  }

  Future<BrandModel> getBrandById(String brandId) async {
    try {
      final doc = await _db.collection('Brands').doc(brandId).get();
      return BrandModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw Exception('Không thể tải thương hiệu: $e');
    }
  }

  Future<void> addBrand(BrandModel brand) async {
    try {
      await _db.collection('Brands').doc(brand.id).set(brand.toJson());
    } catch (e) {
      throw Exception('Thêm thương hiệu thất bại: $e');
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection('Brands').doc(brand.id).update(brand.toJson());
    } catch (e) {
      throw Exception('Cập nhật thương hiệu thất bại: $e');
    }
  }

  Future<void> deleteBrand(String id) async {
    try {
      await _db.collection('Brands').doc(id).delete();
    } catch (e) {
      throw Exception('Xóa thương hiệu thất bại: $e');
    }
  }
}
