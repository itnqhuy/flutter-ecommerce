import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/shop/models/sku_model.dart';

class SkuRepository {
  static final _db = FirebaseFirestore.instance;

  // 🔥 Lấy SKU mặc định theo Product ID
  static Future<SkuModel?> getDefaultSkuByProductId(String productId) async {
    try {
      final productRef = _db.collection('Products').doc(productId);
      final snapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .where('status', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return SkuModel.fromDocumentSnapshot(snapshot.docs.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 🔥 Lấy SKU có giá thấp nhất theo Product ID
  static Future<SkuModel?> getCheapestSkuByProductId(String productId) async {
    try {
      final productRef = _db.collection('Products').doc(productId);
      final snapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .where('status', isEqualTo: true)
          .orderBy('price')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return SkuModel.fromDocumentSnapshot(snapshot.docs.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 🔥 Lấy tất cả SKU theo Product ID
  static Future<List<SkuModel>> getAllSkusByProductId(String productId) async {
    try {
      final productRef = _db.collection('Products').doc(productId);
      final snapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .get();

      return snapshot.docs
          .map((doc) => SkuModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // 🔥 Lấy danh sách ID của SKU theo Product ID
  static Future<List<String>> getSkuIdsByProductId(String productId) async {
    try {
      final productRef = _db.collection('Products').doc(productId);
      final snapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      return [];
    }
  }

  // 🔥 Lấy tên thương hiệu của SKU dựa trên SKU ID
  static Future<String?> getBrandNameOfSku(String skuId) async {
    try {
      final skuDoc = await _db.collection('SKUs').doc(skuId).get();
      if (!skuDoc.exists) return null;

      final dataSku = skuDoc.data() ?? {};
      final productRef = dataSku['productId'] as DocumentReference;

      final productDoc = await productRef.get();
      if (!productDoc.exists) return null;

      final dataProduct = productDoc.data() as Map<String, dynamic>? ?? {};
      final brandRef = dataProduct['idBrand'] as DocumentReference;

      final brandDoc = await brandRef.get();
      if (!brandDoc.exists) return null;

      final dataBrand = brandDoc.data() as Map<String, dynamic>? ?? {};
      return dataBrand['name'] as String?;
    } catch (e) {
      return null;
    }
  }
}
