import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_buttons.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_image.dart';
import 'package:circlechat_app/presentation/widgets/external_link_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communities'),
        titleSpacing: AppSizes.globalPadding,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: AppSizes.bodyPadding,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImage(
                  assetPath: KImages.communitiesIllustration,
                  width: AppSizes.emptyPageImageSize,
                  height: AppSizes.emptyPageImageSize,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Stay connected with a community',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            AppSizes.verticalPadding,
            Text(
              'Communities bring members together in topic-based groups, and make it easy to get admin announcements. Any community you\'re added to will appear here.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const ExternalLinkText(
              link: 'See example communities',
              showArrow: true,
            ),
            const SizedBox(height: 32),
            AppElevatedButton(
              onPressed: () {},
              text: 'Start your community',
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}
