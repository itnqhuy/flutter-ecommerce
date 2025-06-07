import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/sku_attribute_controller.dart';
import '../../../models/product_model.dart';

class MyProductAttributes extends StatefulWidget {
  const MyProductAttributes({super.key, required this.product});
  final ProductModel product;

  @override
  State<MyProductAttributes> createState() => _MyProductAttributesState();
}

class _MyProductAttributesState extends State<MyProductAttributes> {
  late final SkuAttributeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<SkuAttributeController>()
        ? Get.find<SkuAttributeController>()
        : Get.put(SkuAttributeController());

    controller.fetchAndPrepare(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    final textColor = dark ? Colors.white : Colors.black;

    return Obx(() {
      if (!controller.isInitialized.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.allProductAttrs.isEmpty) {
        return Center(
          child: Text(
            'Không có thuộc tính nào để hiển thị.',
            style: TextStyle(color: textColor),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.allProductAttrs.map((attr) {
          final name = attr.name;
          final values = controller.getAvailableValues(name);
          final selected = controller.selectedAttributes[name];
          final unavailable = controller.getUnavailableValues(name);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySectionHeading(
                title: name,
                showActionButton: false,
                textColor: textColor,
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              Wrap(
                spacing: 8,
                children: values.map((value) {
                  final isSelected = selected == value;
                  final isDisabled = unavailable.contains(value);

                  return MyChoiceChip(
                    text: value,
                    selected: isSelected,
                    isDisabled: isDisabled,
                    onSelected: isDisabled
                        ? null
                        : (selected) async {
                            // gọi async và chờ xử lý
                            if (selected) {
                              await controller.onAttributeSelected(name, value);
                            } else {
                              await controller.onAttributeSelected(name, '');
                            }
                          },
                  );
                }).toList(),
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
            ],
          );
        }).toList(),
      );
    });
  }
}
