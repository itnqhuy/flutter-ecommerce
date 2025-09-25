import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class MyChoiceChip extends StatelessWidget {
  const MyChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
    this.isDisabled = false,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final isColor = MyHelperFunctions.getColor(text) != null;

    // Màu nền cơ bản cho chip
    final baseColor = isColor
        ? MyHelperFunctions.getColor(text)!
        : selected
            ? (dark ? MyColors.primaryLight : MyColors.primary)
            : (dark ? Colors.grey.shade800 : MyColors.grey);

    // Nếu disabled thì làm mờ màu nền
    final backgroundColor =
        isDisabled ? baseColor.withAlpha((255 * 0.3).round()) : baseColor;

    // Màu chữ theo trạng thái và dark mode
    final labelColor = isDisabled
        ? (dark ? Colors.grey.shade600 : const Color.fromARGB(255, 39, 38, 38))
        : selected
            ? MyColors.white
            : (dark ? Colors.white70 : Colors.black87);

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: isDisabled ? null : onSelected,
        labelStyle: TextStyle(
          color: labelColor,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
        avatar: isColor
            ? MyCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: backgroundColor,
              )
            : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
        selectedColor: baseColor,
        backgroundColor: dark ? Colors.grey.shade800 : Colors.grey.shade200,
        disabledColor: Colors.grey.shade300,
        surfaceTintColor: Colors.transparent,
        side: BorderSide(
          color: selected
              ? (dark ? MyColors.primaryLight : MyColors.primary)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
    );
  }
}
