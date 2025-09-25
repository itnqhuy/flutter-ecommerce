import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/shop/models/rating_model.dart';

class RatingRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<List<RatingModel>> getRatingsByProductId(
      String productId) async {
    try {
      final productRef =
          FirebaseFirestore.instance.collection('Products').doc(productId);

      final skuSnapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .get();

      final skuRefs = skuSnapshot.docs.map((doc) => doc.reference).toList();

      if (skuRefs.isEmpty || skuRefs.length > 10) return [];

      final ratingSnapshot = await _db
          .collection('Ratings')
          .where('skuId', whereIn: skuRefs)
          .get();

      return ratingSnapshot.docs
          .map((doc) => RatingModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
