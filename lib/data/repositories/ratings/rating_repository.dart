import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
=======

>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
import '../../../features/shop/models/rating_model.dart';

class RatingRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<List<RatingModel>> getRatingsByProductId(
      String productId) async {
    try {
<<<<<<< HEAD
      final skuSnapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productId)
          .get();
      final skuRefs = skuSnapshot.docs.map((doc) => doc.reference).toList();
=======
      final productRef =
          FirebaseFirestore.instance.collection('Products').doc(productId);

      final skuSnapshot = await _db
          .collection('SKUs')
          .where('productId', isEqualTo: productRef)
          .get();

      final skuRefs = skuSnapshot.docs.map((doc) => doc.reference).toList();

>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      if (skuRefs.isEmpty || skuRefs.length > 10) return [];

      final ratingSnapshot = await _db
          .collection('Ratings')
          .where('skuId', whereIn: skuRefs)
          .get();
<<<<<<< HEAD
=======

>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      return ratingSnapshot.docs
          .map((doc) => RatingModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
