import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../shop/controllers/shippinginfo/address_input_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressInputController());

    return Scaffold(
      appBar: MyAppBar(showBackArrow: true, title: Text('Thêm địa chỉ mới')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                // Họ và tên
                TextFormField(
                    controller: controller.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: 'Họ và tên')),
                const SizedBox(height: MySizes.spaceBtwInputFields),

                // Số điện thoại
                TextFormField(
                    controller: controller.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: 'Số điện thoại')),
                const SizedBox(height: MySizes.spaceBtwInputFields),

                // Địa chỉ chi tiết
                TextFormField(
                    controller: controller.detailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.building_3),
                        labelText: 'Địa chỉ chi tiết')),
                const SizedBox(height: MySizes.spaceBtwInputFields),

                // Thành phố/Tỉnh
                TextFormField(
                    controller: controller.provinceOrCity,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.building),
                        labelText: 'Thành phố / Tỉnh')),
                const SizedBox(height: MySizes.spaceBtwInputFields),

                // Quận/Huyện
                TextFormField(
                    controller: controller.district,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.activity),
                        labelText: 'Quận / Huyện')),
                const SizedBox(height: MySizes.spaceBtwInputFields),

                // Phường/Xã
                TextFormField(
                    controller: controller.ward,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.global),
                        labelText: 'Phường / Xã')),
                const SizedBox(height: MySizes.defaultSpace),

                // Checkbox chọn địa chỉ mặc định
                Obx(() => CheckboxListTile(
                      value: controller.isDefault.value,
                      onChanged: (value) =>
                          controller.isDefault.value = value ?? false,
                      title: Text('Đặt làm địa chỉ mặc định'),
                      controlAffinity: ListTileControlAffinity.leading,
                    )),
                const SizedBox(height: MySizes.defaultSpace),

                // Nút lưu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: Text('Lưu'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
