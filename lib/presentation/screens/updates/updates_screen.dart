import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/data/models/status_model.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSizes.globalPadding,
        title: const Text('Updates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.bodyVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.globalPadding,
                ),
                child: Text(
                  'Status',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              AppListTile(
                leading: ProfileAvatar(
                  profileId: 'my-dummy-uid',
                  imageUrl: KImages.currentUserDummy,
                  status: StatusModel(
                    id: 'temporary-status-id',
                    timestamp: DateTime.now(),
                    userId: 'my-dummy-uid',
                    imageUrl: KImages.currentUserDummyStatus,
                  ),
                ),
                title: 'My status',
                subtitle: 'Tap to add status update',
              ),
              const Divider(),
              AppSizes.verticalPaddingMid,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.globalPadding,
                ),
                child: Text(
                  'Channels',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              AppSizes.verticalPaddingMin,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.globalPadding,
                ),
                child: Text(
                  'Stay updated on topics that matter to you. Find channels to follow below.',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              AppSizes.verticalPaddingMax,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.globalPadding,
                ),
                child: Text(
                  'Find channels to follow',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.labelLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              AppSizes.verticalPaddingMid,
              _buildChannelTile(
                'assets/images/top_rank_boxing_logo.png',
                'Top Rank Boxing',
                '4.2M followers',
                context,
              ),
              _buildChannelTile(
                'assets/images/call_of_duty_logo.png',
                'Call of Duty',
                '6.8M followers',
                context,
              ),
              _buildChannelTile(
                'assets/images/circlechat_logo.png',
                'CircleChat',
                '233M followers',
                context,
              ),
              _buildChannelTile(
                'assets/images/arsenal_logo.png',
                'Arsenal',
                '10.6M followers',
                context,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.globalPadding,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Explore more'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            mini: true,
            child: const Icon(
              Icons.edit,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelTile(
    String imagePath,
    String title,
    String subtitle,
    BuildContext context,
  ) {
    return ListTile(
      leading: ProfileAvatar(
        profileId: title,
        isChannel: true,
        imageUrl:
            'https://yt3.googleusercontent.com/2KbDSaZ6r5w_kXcG1LukeN3NfXnt7QxvgRCn-jmb3AalU7QR3rCRArQWNOBATRFNXMbspoYB=s900-c-k-c0x00ffffff-no-rj',
      ),
      minLeadingWidth: 8,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.globalPadding,
      ),
      horizontalTitleGap: 8,
      title: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.verified, color: Colors.blue, size: 16),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
      trailing: TextButton(
        onPressed: () {},
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.all(
                AppColors.selectedColor,
              ),
            ),
        child: const Text(
          'Follow',
          style: TextStyle(
            color: AppColors.primaryDark,
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
