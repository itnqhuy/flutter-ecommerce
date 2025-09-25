import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../features/shop/models/product_attribute_model.dart';
import '../../../features/shop/models/product_model.dart';
<<<<<<< HEAD
=======
import '../../../features/shop/models/rating_model.dart';
import '../../../features/shop/models/sku_model.dart';
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import '../../../utils/exceptions/my_firebase_exception.dart';

class ProductRepository {
  static ProductRepository get instance => _instance;
  static final ProductRepository _instance = ProductRepository._internal();
  factory ProductRepository() => _instance;
  ProductRepository._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

<<<<<<< HEAD
=======
  // Lấy danh sách sản phẩm nổi bật
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
=======
  // Lấy tất cả sản phẩm nổi bật
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
=======
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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
  Future<List<ProductModel>> getFeatureProductsByCategory(
      String categoryId) async {
    try {
      final cateRef = _db.doc('Categories/$categoryId');
=======
  // Lấy sản phẩm nổi bật theo category
  Future<List<ProductModel>> getFeatureProductsByCategory(
      String categoryId) async {
    try {
      final categoryRef = _db.collection('Categories').doc(categoryId);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

      final snapshot = await _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
          .where('isFeatured', isEqualTo: true)
<<<<<<< HEAD
          .where('idCategory', isEqualTo: cateRef)
=======
          .where('idCategory', isEqualTo: categoryRef)
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
  Future<List<ProductModel>> getProductsByCategory(
      String categoryId, int limit) async {
    try {
      final cateRef = _db.doc('Categories/$categoryId');
=======
  // Lấy sản phẩm theo category
  Future<List<ProductModel>> getProductsByCategory(
      String categoryId, int limit) async {
    try {
      final categoryRef = _db.collection('Categories').doc(categoryId);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

      Query query = _db
          .collection('Products')
          .where('status', isEqualTo: 'published')
<<<<<<< HEAD
          .where('idCategory', isEqualTo: cateRef);
=======
          .where('idCategory', isEqualTo: categoryRef);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

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

<<<<<<< HEAD
  Future<List<ProductModel>> getProductsByBrand(String brandId) async {
    try {
      final brandRef = _db.doc('Brands/$brandId');
=======
  // Lấy sản phẩm theo brand
  Future<List<ProductModel>> getProductsByBrand(String brandId) async {
    try {
      final brandRef = _db.collection('Brands').doc(brandId);
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

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

<<<<<<< HEAD
=======
  // Lấy thuộc tính sản phẩm
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
=======
  // Lấy sản phẩm theo Query tùy chỉnh
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();

<<<<<<< HEAD
      debugPrint('Products fetched by query: ${querySnapshot.docs.length}');
=======
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      return querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw MyFirebaseAuthException(e.code, e.message ?? 'Lỗi Firebase');
    } on Exception catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải danh mục: $e');
    }
  }

<<<<<<< HEAD
=======
  // Lấy danh sách sản phẩm yêu thích theo ID
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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
<<<<<<< HEAD
=======

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
      print("Error getting rating: $e");
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
      print("Lỗi khi lấy đánh giá: $e");
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
      print("Error fetching SKUs: $e");
      return [];
    }
  }
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
}
