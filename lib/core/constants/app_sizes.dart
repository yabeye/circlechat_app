import 'package:circlechat_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSizes {
  // Spacings
  static const double globalPadding = 8.0;
  static const double appBarLeadingWidth = 8.0;
  static const double bodyVerticalPadding = 16;
  static const double bodyHorizontalPadding = 16;
  static const bodyPadding = EdgeInsets.symmetric(
    vertical: bodyVerticalPadding,
    horizontal: bodyHorizontalPadding,
  );
  static Padding verticalPadding = const Padding(
    padding: EdgeInsets.symmetric(
      vertical: 3,
    ),
  );
  static Padding horizontalPadding = const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 3,
    ),
  );

  // image sizes
  static final emptyPageImageSize = AppScreenUtils.height * .2;
}
