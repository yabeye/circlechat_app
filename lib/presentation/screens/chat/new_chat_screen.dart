import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/core/utils/app_formatters.dart';
import 'package:circlechat_app/core/utils/theme_utils.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_buttons.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppListTile(
          title: 'Select Contact',
          subtitle: '92 contacts',
        ),
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
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.globalPadding,
        ),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.greyLight,
            ),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  AppListTile(
                    leading: Container(
                      width: AppSizes.profilePicSize * .8,
                      height: AppSizes.profilePicSize * .8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.group_add,
                        size: AppSizes.profilePicSize * .5,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    title: 'New Group',
                    titleStyle: ThemeUtils.chatListTileTitleTextStyle(context),
                    onTap: () {},
                  ),
                  AppListTile(
                    leading: Container(
                      width: AppSizes.profilePicSize * .8,
                      height: AppSizes.profilePicSize * .8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.person_add_alt_1,
                        size: AppSizes.profilePicSize * .5,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    title: 'New Contact',
                    titleStyle: ThemeUtils.chatListTileTitleTextStyle(context),
                    trailing: const Icon(Icons.qr_code),
                    onTap: () {},
                  ),
                  AppListTile(
                    leading: Container(
                      width: AppSizes.profilePicSize * .8,
                      height: AppSizes.profilePicSize * .8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.people,
                        size: AppSizes.profilePicSize * .5,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    title: 'New Community',
                    titleStyle: ThemeUtils.chatListTileTitleTextStyle(context),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppSizes.globalPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Contacts on CircleChat',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return AppListTile(
                    leading: ProfileAvatar(
                      profileId: 'profileId',
                      showOnline: false,
                      imageUrl: KImages.profilePlaceholder,
                      width: AppSizes.profilePicSize * .8,
                      height: AppSizes.profilePicSize * .8,
                    ),
                    title: 'Abraham',
                    titleStyle: ThemeUtils.chatListTileTitleTextStyle(context),
                    subtitle: 'Hey there! I am using CircleChat.',
                    onTap: () {
                      // Navigator.of(context).pushNamed('/chat');
                    },
                  );
                },
                childCount: 3,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppSizes.globalPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Invite to CircleChat',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return AppListTile(
                    leading: ProfileAvatar(
                      profileId: 'profileId_$index',
                      showOnline: false,
                      width: AppSizes.profilePicSize * .8,
                      height: AppSizes.profilePicSize * .8,
                    ),
                    title: 'Abraham',
                    titleStyle: ThemeUtils.chatListTileTitleTextStyle(context),
                    onTap: () {
                      // Navigator.of(context).pushNamed('/chat');
                    },
                    trailing: AppTextButton(
                      onPressed: () {
                        // invite logic will go here //
                      },
                      text: 'Invite',
                    ),
                  );
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
