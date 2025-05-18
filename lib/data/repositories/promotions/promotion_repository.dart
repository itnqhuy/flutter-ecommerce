import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/shop/models/promotion_model.dart';

class PromotionRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<PromotionModel?> getLatestBySkuId(String skuId) async {
    try {
      final snapshot = await _db
          .collection('Promotions')
          .where('skuId', isEqualTo: _db.doc('SKUs/$skuId'))
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return PromotionModel.fromSnapshot(snapshot.docs.first);
    } catch (e) {
      return null;
    }
  }

  static Future<List<PromotionModel>> getAllBySkuId(String skuId) async {
    try {
      final snapshot = await _db
          .collection('Promotions')
          .where('skuId', isEqualTo: _db.doc('SKUs/$skuId'))
          .get();

      return snapshot.docs
          .map((doc) => PromotionModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
