import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Images
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.filePath,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String? imageUrl;
  final String? assetPath;
  final String? filePath;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    // Determine which image source to use
    Widget imageWidget;
    if (imageUrl != null) {
      imageWidget = Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error); // Error handling for network images
        },
      );
    } else if (assetPath != null) {
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (filePath != null) {
      imageWidget = Image.file(
        File(filePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error); // Error handling for file images
        },
      );
    } else {
      // Fallback to an empty container if no image source is provided
      return Container();
    }

    // Wrap the image with ClipRRect for rounded corners
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: imageWidget,
    );
  }
}

// Icons

enum SvgType {
  asset,
  file,
  network;
}

class AppSvg extends StatelessWidget {
  const AppSvg({
    required this.path,
    this.height,
    super.key,
    this.width,
    this.fit,
    this.type = SvgType.asset,
    this.color,
  });

  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final SvgType type;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? width,
      width: width,
      child: _svg,
    );
  }

  Widget get _svg {
    switch (type) {
      case SvgType.asset:
        return SvgPicture.asset(
          path,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color!,
                  BlendMode.srcIn,
                )
              : null,
        );
      case SvgType.file:
        return SvgPicture.file(
          File(path),
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color!,
                  BlendMode.srcIn,
                )
              : null,
        );
      case SvgType.network:
        return SvgPicture.network(
          path,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color!,
                  BlendMode.srcIn,
                )
              : null,
        );
    }
  }
}

// CachedNetworkImage
class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
      ),
    );
  }
}
