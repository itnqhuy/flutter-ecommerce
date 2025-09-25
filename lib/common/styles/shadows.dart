import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class MyShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: MyColors.darkGrey.withAlpha((255 * 0.1).round()),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: MyColors.darkGrey.withAlpha((255 * 0.1).round()),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
