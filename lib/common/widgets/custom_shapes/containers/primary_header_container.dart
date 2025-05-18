import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class MyPrimaryHeaderContainer extends StatelessWidget {
  const MyPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MyCurvedEdgeWidget(
      child: Container(
        width: double.infinity,
        color: MyColors.primary,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            // Các vòng tròn nền trang trí
            Positioned(
              top: -150,
              right: -250,
              child: MyCircularContainer(
                backgroundColor:
                    MyColors.textWhite.withAlpha((255 * 0.1).round()),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: MyCircularContainer(
                  backgroundColor:
                      MyColors.textWhite.withAlpha((255 * 0.1).round())),
            ),

            // Nội dung chính, không ép height
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
