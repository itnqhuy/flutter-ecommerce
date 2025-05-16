import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw e.message ?? 'Lỗi Firebase';
    } on PlatformException catch (e) {
      throw e.message ?? 'Lỗi nền tảng';
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại!';
    }
  }

  Future<List<ProductModel>> getAllPublishedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      throw 'Không thể tải sản phẩm: $e';
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      throw 'Không thể tải theo category: $e';
    }
  }

  Future<List<ProductModel>> getProductsByBrand(String brandId) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('brandId', isEqualTo: brandId)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      throw 'Không thể tải theo thương hiệu: $e';
    }
  }
}
