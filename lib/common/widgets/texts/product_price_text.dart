import 'package:ecommerce/utils/formatters/fomatter.dart';
import 'package:flutter/material.dart';

class MyProductPriceText extends StatelessWidget {
  const MyProductPriceText({
    super.key,
    this.currencySign = 'đ',
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign;
  final int price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currencySign ${MyFormatter.formatDecimalOnly(price)}',
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
              )
          : Theme.of(context).textTheme.titleLarge!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
              ),
    );
  }
}
