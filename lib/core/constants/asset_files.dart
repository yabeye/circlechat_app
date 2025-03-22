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

  // Dummy Network images
  static const String currentUserDummy =
      'https://avatars.githubusercontent.com/u/88554326?v=4';
  static const String currentUserDummyStatus =
      'https://images.unsplash.com/photo-1520454974749-611b7248ffdb?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGJlYWNofGVufDB8fDB8fHww';
  static const String profilePlaceholder =
      'https://yt3.googleusercontent.com/2KbDSaZ6r5w_kXcG1LukeN3NfXnt7QxvgRCn-jmb3AalU7QR3rCRArQWNOBATRFNXMbspoYB=s900-c-k-c0x00ffffff-no-rj';
}
