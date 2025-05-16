import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyProductAttributes extends StatelessWidget {
  const MyProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //Selected Attributes
        MyRoundedContainer(
          padding: const EdgeInsets.all(MySizes.md),
          backgroundColor: dark ? MyColors.darkerGrey : MyColors.grey,
          child: Column(
            children: [
              //Title price stock
              Row(
                children: [
                  const MySectionHeading(title: 'Variation'),
                  const SizedBox(width: MySizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const MyProductTitleText(
                              title: 'Price: ', smallSize: true),
                          //Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: MySizes.spaceBtwItems),

                          //Sale Tag
                          MyProductPriceText(price: 20),
                        ],
                      ),

                      //Stock
                      Row(
                        children: [
                          const MyProductTitleText(
                              title: 'Stock: ', smallSize: true),
                          Text('In Stock',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              //Variation Description
              MyProductTitleText(
                title: 'Desasdnasdbbuwdwiucbiuabube',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: MySizes.spaceBtwItems),

        //Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(height: MySizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                MyChoiceChip(
                    text: 'Blue', selected: false, onSelected: (value) {}),
                MyChoiceChip(
                    text: 'Green', selected: true, onSelected: (value) {}),
                MyChoiceChip(
                    text: 'Yellow', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySectionHeading(title: 'Size', showActionButton: false),
            const SizedBox(height: MySizes.spaceBtwItems / 2),
            Wrap(
              children: [
                MyChoiceChip(
                    text: '34', selected: true, onSelected: (value) {}),
                MyChoiceChip(
                    text: '35', selected: false, onSelected: (value) {}),
                MyChoiceChip(
                    text: '36', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
