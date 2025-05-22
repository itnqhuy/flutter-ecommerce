import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/shippinginfo/shipping_info_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class MyBillingAddressSection extends StatelessWidget {
  const MyBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MySectionHeading(
          title: 'Địa chỉ giao hàng',
          buttonTitle: 'Thay đổi',
          onPressed: () => addressController.selectedNewAddressPopup(context),
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(addressController.selectedAddress.value.name,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.grey, size: 16),
                      const SizedBox(width: MySizes.spaceBtwItems),
                      Text(addressController.selectedAddress.value.phone,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(Icons.location_history,
                          color: Colors.grey, size: 16),
                      const SizedBox(width: MySizes.spaceBtwItems),
                      Expanded(
                        child: Text(
                          '${addressController.selectedAddress.value.detailAddress}, ${addressController.selectedAddress.value.ward}, ${addressController.selectedAddress.value.district}, ${addressController.selectedAddress.value.provinceOrCity}',
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Text('Chọn địa chỉ giao hàng',
                style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
