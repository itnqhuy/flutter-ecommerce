import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/shop/models/sku_model.dart';

class SkuRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<SkuModel?> getDefaultSkuByProductId(String productId) async {
    final snapshot = await _db
        .collection('SKUs')
        .where('productId', isEqualTo: productId)
        .where('status', isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return SkuModel.fromJson(doc.data());
    }
    return null;
  }

  static Future<SkuModel?> getCheapestSkuByProductId(String productId) async {
    final snapshot = await _db
        .collection('SKUs')
        .where('productId', isEqualTo: productId)
        .where('status', isEqualTo: true)
        .orderBy('price')
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      return SkuModel.fromJson(doc.data());
    }

    return null;
  }

  static Future<List<SkuModel>> getAllSkusByProductId(String productId) async {
    final snapshot = await _db
        .collection('SKUs')
        .where('productId', isEqualTo: productId)
        .get();

    return snapshot.docs.map((doc) => SkuModel.fromJson(doc.data())).toList();
  }
}
