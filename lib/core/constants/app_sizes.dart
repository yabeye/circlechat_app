import 'package:circlechat_app/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSizes {
  // Spacings
  static const double globalPadding = 16.0;
  static const double appBarLeadingWidth = 8.0;
  static const double bodyVerticalPadding = 16;
  static const double bodyHorizontalPadding = 16;
  static const bodyPadding = EdgeInsets.symmetric(
    vertical: bodyVerticalPadding,
    horizontal: bodyHorizontalPadding,
  );
  static Padding verticalPaddingMin = const Padding(
    padding: EdgeInsets.symmetric(
      vertical: 3,
    ),
  );
  static Padding verticalPaddingMid = const Padding(
    padding: EdgeInsets.symmetric(
      vertical: 8,
    ),
  );

  static Padding verticalPaddingMax = const Padding(
    padding: EdgeInsets.symmetric(
      vertical: 16,
    ),
  );
  static Padding horizontalPaddingMin = const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 3,
    ),
  );

  // image sizes
  static final emptyPageImageSize = AppScreenUtils.height * .2;
  static final profilePicSize = 50.0.w;
}
