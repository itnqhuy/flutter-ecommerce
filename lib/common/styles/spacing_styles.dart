import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../utils/constants/sizes.dart';

class MySpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: kIsWeb ? 0 : MySizes.appBarHeight,
    bottom: MySizes.defaultSpace,
    left: MySizes.defaultSpace,
    right: MySizes.defaultSpace,
  );
}
