import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/addresses/address_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/shipping_info.dart';

class AddressInputController extends GetxController {
  final name = TextEditingController();
  final phone = TextEditingController();
  final detailAddress = TextEditingController();
  final provinceOrCity = TextEditingController();
  final district = TextEditingController();
  final ward = TextEditingController();
  final isDefault = false.obs;

  final addressRepository = Get.put(AddressRepository());

  /// Hàm để lấy `DocumentReference` của user hiện tại
  DocumentReference get currentUserRef {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User chưa đăng nhập");
    return FirebaseFirestore.instance.collection('Users').doc(uid);
  }

  /// Hàm lưu địa chỉ mới
  Future<void> addNewAddress() async {
    try {
      final newAddress = ShippingInfoModel(
          id: '',
          name: name.text.trim(),
          phone: phone.text.trim(),
          detailAddress: detailAddress.text.trim(),
          provinceOrCity: provinceOrCity.text.trim(),
          district: district.text.trim(),
          ward: ward.text.trim(),
          isDefault: isDefault.value,
          userId: currentUserRef,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now());

      await addressRepository.addAddress(newAddress);
      MyLoaders.successSnackBar(title: "Thêm địa chỉ thành công");
      Get.back(); // quay về màn trước
    } catch (e) {
      MyLoaders.errorSnackBar(
          title: "Lỗi khi thêm địa chỉ", message: e.toString());
    }
  }

  @override
  void onClose() {
    name.dispose();
    phone.dispose();
    detailAddress.dispose();
    provinceOrCity.dispose();
    district.dispose();
    ward.dispose();
    super.onClose();
  }
}
