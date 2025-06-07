import 'package:flutter/material.dart';
import '../layouts/grid_layout.dart';
import 'shimmer_effect.dart';

class MyBrandShimmer extends StatelessWidget {
  const MyBrandShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MyGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const MyShimmerEffect(width: 300, height: 80),
    );
  }
}
