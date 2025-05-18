import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';
import '../../../utils/exceptions/my_platform_exception.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Lấy danh sách banner có trạng thái 'active'
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();

      return result.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } on FormatException {
      throw const FormatException("Dữ liệu không đúng định dạng.");
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải banner: $e');
    }
  }
}
