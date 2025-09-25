import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/sku_attribute_model.dart';

class SkuAttributeRepository {
  static final _db = FirebaseFirestore.instance;
<<<<<<< HEAD
  static Future<QuerySnapshot<Map<String, dynamic>>> getAttributesBySkuId(
      String skuId) async {
    return await _db
        .collection('SkuAttributes')
        .where('SKUId', isEqualTo: _db.doc('SKUs/$skuId'))
        .get();
  }
=======
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

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
<<<<<<< HEAD
          .collection('SkuAttributes')
=======
          .collection('SKUAttributes')
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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
<<<<<<< HEAD
=======

  static Future<int> countAttributesOfSku(String skuId) async {
    final skuRef = _db.collection('SKUs').doc(skuId);

    final snapshot = await _db
        .collection('SKUAttributes')
        .where('SKUId', isEqualTo: skuRef)
        .get();

    return snapshot.size;
  }
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
}
