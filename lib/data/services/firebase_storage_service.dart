import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/shop/models/banner_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../utils/exceptions/my_firebase_exception.dart';
import '../../utils/exceptions/my_platform_exception.dart';

class MyFirebaseStorageService extends GetxController {
  static MyFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;
  final _db = FirebaseFirestore.instance;

  /// Lấy dữ liệu ảnh từ local asset
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      return byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );
    } catch (e) {
      throw Exception('Không thể load ảnh từ asset: $e');
    }
  }

  /// Upload ảnh dung ImageData tren FS và trả về URL
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref().child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Lỗi Firebase: ${e.message}';
      } else if (e is SocketException) {
        throw 'Lỗi mạng: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Lỗi nền tảng: ${e.message}';
      } else {
        throw 'Có lỗi xảy ra. Vui lòng thử lại';
      }
    }
  }

  // Upload ảnh lên Firebase Storage và trả về URL
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref().child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Lỗi Firebase: ${e.message}';
      } else if (e is SocketException) {
        throw 'Lỗi mạng: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Lỗi nền tảng: ${e.message}';
      } else {
        throw 'Có lỗi xảy ra. Vui lòng thử lại';
      }
    }
  }

  // Upload dummy data danh mục lên Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      for (var category in categories) {
        category.imageUrl = category.imageUrl;

        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi upload danh mục: $e');
    }
  }

  Future<void> uploadDummyBanners(List<BannerModel> banners) async {
    try {
      for (var banner in banners) {
        await _db
            .collection('Banners')
            .doc() // Firebase tự sinh ID
            .set(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message);
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code, e.message);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi upload banner: $e');
    }
  }
}
