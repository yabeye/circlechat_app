// Icon files

import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class KIcons {
  // Asset SVG files
  static const String _baseIcons = 'assets/icons/';
  static const String logo = '${_baseIcons}logo.svg';

  // Material icons
  static Widget defaultProfilePic({double size = 48}) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.disabled,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.person,
            size: size * .9,
            color: AppColors.textDark,
          ),
        ),
      );
  static Widget defaultGroupProfilePic({double size = 48}) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.disabled,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.group,
          size: size * .6,
          color: AppColors.textDark,
        ),
      );
}

// Image files

abstract class KImages {
  static const String _baseImages = 'assets/images/';
  static const String communitiesIllustration =
      '${_baseImages}communities_illustration.jpg';
}
