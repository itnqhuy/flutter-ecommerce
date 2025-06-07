import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/shop/models/shipping_info.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class AddressRepository {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<ShippingInfoModel>> fetchUserAddresses() async {
    try {
      final DocumentReference userRef = _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid);

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('ShippingInfos')
          .where('userId', isEqualTo: userRef)
          .get();

      return querySnapshot.docs
          .map((doc) => ShippingInfoModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      MyLoaders.errorSnackBar(
          title: 'Không tìm thấy địa chỉ', message: e.toString());
      return [];
    }
  }

  Future<void> updateSelectedField(String shippingId, bool selected) async {
    try {
      await FirebaseFirestore.instance
          .collection('ShippingInfos')
          .doc(shippingId)
          .update({'isDefault': selected, 'updatedAt': Timestamp.now()});
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Lỗi khi cập nhật', message: e.toString());
    }
  }

  Future<void> addAddress(ShippingInfoModel address) async {
    final docRef = FirebaseFirestore.instance.collection('ShippingInfos').doc();
    await docRef.set(address.copyWith(id: docRef.id).toJson());
  }
}
