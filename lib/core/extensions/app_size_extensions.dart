import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:circlechat_app/core/utils/size_utils.dart';

/// An extension for screen sizes
extension AppSizeExtension on num {
  /// Multiplies Screen Height to this [num]
  double get screenHeight => AppScreenUtils.height * this;

  /// Multiplies Screen Width to this [num]
  double get screenWidth => AppScreenUtils.width * this;

  /// Gets height with respect to screen height for this [num]
  double get appHeight => ScreenUtil().setHeight(this);

  /// Gets width with respect to screen height for this [num]
  double get appWidth => ScreenUtil().setWidth(this);

  /// Gets font size with respect to screen height for this [num]
  double get appText => ScreenUtil().setSp(this);
}
