import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/sku_attribute_model.dart';

class SkuAttributeRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<List<SkuAttributeModel>> getBySkus(List<String> skuIds) async {
    if (skuIds.isEmpty) return [];

    final chunks = <List<String>>[];
    for (var i = 0; i < skuIds.length; i += 10) {
      chunks.add(
          skuIds.sublist(i, i + 10 > skuIds.length ? skuIds.length : i + 10));
    }

    final results = <SkuAttributeModel>[];

    for (final chunk in chunks) {
      final snapshot = await _db
          .collection('SKUAttributes')
          .where('SKUId',
              whereIn: chunk.map((id) => _db.doc('SKUs/$id')).toList())
          .get();

      final chunkResult = snapshot.docs
          .map((doc) => SkuAttributeModel.fromDocumentSnapshot(doc))
          .toList();

      results.addAll(chunkResult);
    }

    return results;
  }

  static Future<int> countAttributesOfSku(String skuId) async {
    final skuRef = _db.collection('SKUs').doc(skuId);

    final snapshot = await _db
        .collection('SKUAttributes')
        .where('SKUId', isEqualTo: skuRef)
        .get();

    return snapshot.size;
  }
}
