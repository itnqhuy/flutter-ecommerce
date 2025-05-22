import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/shop/models/product_attribute_model.dart';

class ProductAttributeRepository {
  static final _db = FirebaseFirestore.instance;

  /// Lấy danh sách thuộc tính (Color, Size, ...) của 1 sản phẩm
  static Future<List<ProductAttributeModel>> getByProductId(
      String productId) async {
    final snapshot = await _db
        .collection('ProductAttribute')
        .where('productId', isEqualTo: _db.doc('Products/$productId'))
        .get();
    return snapshot.docs
        .map((doc) => ProductAttributeModel.fromDocumentSnapshot(doc))
        .toList();
  }
}
