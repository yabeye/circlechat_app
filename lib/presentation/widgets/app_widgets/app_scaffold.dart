import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.backgroundImage,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final String? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.greyLight,
            ),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (backgroundImage != null)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: AppCachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: backgroundImage!,
                  ),
                ),
              ),
            body ?? const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
