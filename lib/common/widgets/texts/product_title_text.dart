import 'package:flutter/material.dart';

class MyProductTitleText extends StatelessWidget {
  const MyProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
    this.textColor,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign textAlign;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final baseStyle = smallSize
        ? Theme.of(context).textTheme.labelLarge
        : Theme.of(context).textTheme.titleSmall;

    return Text(
      title,
      style:
          baseStyle?.copyWith(color: textColor) ?? TextStyle(color: textColor),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
