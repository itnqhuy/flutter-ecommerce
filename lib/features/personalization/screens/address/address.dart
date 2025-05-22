import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce/features/shop/controllers/shippinginfo/shipping_info_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: MyColors.white),
      ),
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Địa chỉ của tôi',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: FutureBuilder(
              future: controller.getAllUserAddress(),
              builder: (context, snapshot) {
                final response = MyCloudHelperFunction.checkMultiRecorState(
                  snapshot: snapshot,
                  loader: const Center(child: CircularProgressIndicator()),
                );
                if (response != null) return response;
                final address = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (_, index) => MySingleAddress(
                    address: address[index],
                    onTap: () => controller.selectAddress(address[index]),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
