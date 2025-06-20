import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class MyCircularContainer extends StatelessWidget {
  const MyCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.margin,
    this.padding = 0,
    this.backgroundColor = MyColors.white,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        // ignore: deprecated_member_use
        color: MyColors.textWhite.withOpacity(0.1),
      ),
      child: child,
    );
  }
}
