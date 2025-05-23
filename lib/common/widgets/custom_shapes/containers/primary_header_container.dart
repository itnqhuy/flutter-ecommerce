import 'package:ecommerce/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
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
              child: TCircularContainer(
                backgroundColor: MyColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundColor: MyColors.textWhite.withOpacity(0.1),
              ),
            ),

            // ✅ Nội dung chính, không ép height
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
