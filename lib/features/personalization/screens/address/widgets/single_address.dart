import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/features/shop/controllers/shippinginfo/shipping_info_controller.dart';
import 'package:ecommerce/features/shop/models/shipping_info.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MySingleAddress extends StatelessWidget {
  const MySingleAddress(
      {super.key, required this.address, required this.onTap});

  final ShippingInfoModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        child: MyRoundedContainer(
          showBorder: true,
          padding: const EdgeInsets.all(MySizes.md),
          width: double.infinity,
          backgroundColor: selectedAddress
              ? MyColors.primary.withAlpha((255 * 0.5).round())
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? MyColors.darkerGrey
                  : MyColors.grey,
          margin: const EdgeInsets.only(bottom: MySizes.spaceBtwItems),
          child: Stack(
            children: [
              if (selectedAddress)
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    Iconsax.tick_circle,
                    color: dark ? MyColors.light : MyColors.dark,
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: MySizes.sm / 2),
                  Text(
                    address.phone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: MySizes.sm / 2),
                  Text(
                    '${address.detailAddress}, ${address.ward}, ${address.district}, ${address.provinceOrCity}',
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
