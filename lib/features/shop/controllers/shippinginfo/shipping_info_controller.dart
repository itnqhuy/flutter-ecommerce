import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/addresses/address_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_function.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/screens/address/add_new_address.dart';
import '../../../personalization/screens/address/widgets/single_address.dart';
import '../../models/shipping_info.dart';

class AddressController {
  static AddressController get instance => Get.find();

  final Rx<ShippingInfoModel> selectedAddress = ShippingInfoModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<ShippingInfoModel>> getAllUserAddress() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.isDefault,
          orElse: () => ShippingInfoModel.empty());
      return addresses;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Không tìm thấy địa chỉ');
      return [];
    }
  }

  Future selectAddress(ShippingInfoModel newAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      final updatedAddress = newAddress.copyWith(isDefault: true);
      selectedAddress.value = updatedAddress;
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      MyLoaders.errorSnackBar(
          title: 'Không cập nhật thành công', message: e.toString());
    }
  }

  Future<dynamic> selectedNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySectionHeading(title: 'Chọn địa chỉ giao hàng'),
            FutureBuilder(
              future: getAllUserAddress(),
              builder: (_, snapshot) {
                final response = MyCloudHelperFunction.checkMultiRecorState(
                    snapshot: snapshot);
                if (response != null) return response;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => MySingleAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: MySizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text('Add new address'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
