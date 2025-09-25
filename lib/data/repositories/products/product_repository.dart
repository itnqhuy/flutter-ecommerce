import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../features/shop/models/product_attribute_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/rating_model.dart';
import '../../../features/shop/models/sku_model.dart';
import '../../../utils/exceptions/my_firebase_exception.dart';

class ProductRepository {
  static ProductRepository get instance => _instance;
  static final ProductRepository _instance = ProductRepository._internal();
  factory ProductRepository() => _instance;
  ProductRepository._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      debugPrint('Featured products loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Lỗi tải featured products: $e');
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('isFeatured', isEqualTo: true)
          .get();

      debugPrint('All featured products loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Lỗi tải all featured products: $e');
    }
  }

  // ProductRepository.dart
  static Future<String?> getProductName(String productId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("Products")
          .doc(productId)
          .get();

      if (snapshot.exists) {
        return snapshot.data()?['name'] ?? '';
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Không thể tải sản phẩm: $e');
    }
    return null;
  }

  // Lấy tất cả sản phẩm đã xuất bản
  Future<List<ProductModel>> getAllPublishedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .get();

      debugPrint('All published products loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Không thể tải sản phẩm: $e');
    }
  }

  Future<List<ProductModel>> getFeatureProductsByCategory(
      String categoryId) async {
    try {
      final categoryRef = _db.collection('Categories').doc(categoryId);

      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('isFeatured', isEqualTo: true)
          .where('idCategory', isEqualTo: categoryRef)
          .get();

      debugPrint(
          'Featured products by category ($categoryId) loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Không thể tải theo category: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(
      String categoryId, int limit) async {
    try {
      final categoryRef = _db.collection('Categories').doc(categoryId);

      Query query = _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('idCategory', isEqualTo: categoryRef);

      if (limit > 0) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();

      debugPrint(
          'Products by category ($categoryId) loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Không thể tải theo category: $e');
    }
  }

  Future<List<ProductModel>> getProductsByBrand(String brandId) async {
    try {
      final brandRef = _db.collection('Brands').doc(brandId);

      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('idBrand', isEqualTo: brandRef)
          .get();

      debugPrint(
          'Products by brand ($brandId) loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Không thể tải theo thương hiệu: $e');
    }
  }

  Future<List<ProductAttributeModel>> getByProductId(String productId) async {
    try {
      final snapshot = await _db
          .collection('ProductAttribute')
          .where('productId', isEqualTo: productId)
          .get();

      debugPrint(
          'Attributes by product ($productId) loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductAttributeModel.fromDocumentSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải sản phẩm: $e');
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();

      debugPrint('Products fetched by query: ${querySnapshot.docs.length}');
      return querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải danh mục: $e');
    }
  }

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      if (productIds.isEmpty) return [];

      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      debugPrint('Favorite products loaded: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải danh mục: $e');
    }
  }

  Future<RatingModel?> getRatingById(String ratingId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection('Ratings').doc(ratingId).get();

      if (doc.exists) {
        return RatingModel.fromFirestore(doc);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<RatingModel>> getRatingsByProduct(String productId) async {
    try {
      final productRef = _db.collection('Products').doc(productId);

      // Lấy danh sách SKU của sản phẩm
      QuerySnapshot skuQuery = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .get();

      // Chuyển đổi danh sách SKU thành danh sách DocumentReference
      List<DocumentReference> skuRefs =
          skuQuery.docs.map((doc) => doc.reference).toList();

      if (skuRefs.isEmpty) {
        return []; // Không có SKU thì không có đánh giá
      }

      // Nếu danh sách quá dài (Firestore giới hạn whereIn <= 10), chia nhỏ:
      List<RatingModel> allRatings = [];

      for (int i = 0; i < skuRefs.length; i += 10) {
        final subList = skuRefs.sublist(
            i, i + 10 > skuRefs.length ? skuRefs.length : i + 10);

        QuerySnapshot ratingQuery = await _db
            .collection('Ratings')
            .where('skuId', whereIn: subList)
            .get();

        final ratings = ratingQuery.docs
            .map((doc) => RatingModel.fromFirestore(doc))
            .toList();
        allRatings.addAll(ratings);
      }

      return allRatings;
    } catch (e) {
      throw Exception('Không thể lấy đánh giá sản phẩm');
    }
  }

  Future<List<SkuModel>> fetchSKUsByProduct(String productId) async {
    try {
      // Tạo DocumentReference từ productId
      final productRef = _db.collection('Products').doc(productId);

      // Truy vấn danh sách SKU dựa trên productRef
      QuerySnapshot skuQuery = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef) // Dùng DocumentReference
          .get();

      return skuQuery.docs
          .map((doc) => SkuModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
