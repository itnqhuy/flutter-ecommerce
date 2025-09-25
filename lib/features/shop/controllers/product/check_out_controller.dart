import 'package:ecommerce/common/widgets/list_tiles/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_model.dart';

class CheckOutController extends GetxController {
  static CheckOutController get instance => Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
        image: MyImages.onDelivery, name: 'Thanh toán khi nhận hàng');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              padding: const EdgeInsets.all(MySizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MySectionHeading(
                    title: 'Chọn phương thức thanh toán',
                    showActionButton: false,
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod: PaymentMethodModel(
                        image: MyImages.onDelivery,
                        name: 'Thanh toán khi nhận hàng'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod: PaymentMethodModel(
                        image: MyImages.paypal, name: 'Paypal'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod: PaymentMethodModel(
                        image: MyImages.googlePay, name: 'Google Pay'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod: PaymentMethodModel(
                        image: MyImages.applePay, name: 'Apple Pay'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod:
                        PaymentMethodModel(image: MyImages.visa, name: 'VISA'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod: PaymentMethodModel(
                        image: MyImages.masterCard, name: 'Master Card'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                  MyPaymnetTile(
                    paymentMethod: PaymentMethodModel(
                        image: MyImages.creditCard, name: 'Credit Card'),
                  ),
                  SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            ));
  }
}
