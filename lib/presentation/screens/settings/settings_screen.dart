import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/presentation/cubit/profile/profile_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(getIt()),
        child: ListView(
          children: <Widget>[
            const Divider(),
            buildProfileTile(context),
            const Divider(),
            AppListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: 'Account',
              subtitle: 'Security notifications, change number',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.lock_outline),
              title: 'Privacy',
              subtitle: 'Block contacts, disappearing messages',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.chat_outlined),
              title: 'Chats',
              subtitle: 'Theme, wallpapers, chat history',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: 'Notifications',
              subtitle: 'Message, group & call tones',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.data_usage_outlined),
              title: 'Storage and Data',
              subtitle: 'Network usage, auto-download',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.language_outlined),
              title: 'App Language',
              subtitle: 'English',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.help_outline),
              title: 'Help',
              subtitle: 'FAQ, contact us, privacy policy',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.group_add_outlined),
              title: 'Invite a Friend',
              onTap: () {},
            ),
            AppListTile(
              leading: const Icon(Icons.security_update_good_outlined),
              title: 'App Updates',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileTile(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        String userId = '';
        String name = '...';
        String subtitle = '...';
        String? profileImageUrl;

        if (state is UserDataLoaded) {
          userId = state.userData.uid;
          name = state.userData.name;
          subtitle = state.userData.about ?? '';
          profileImageUrl = state.userData.profileImageUrl;
        }

        return AppListTile(
          leading: ProfileAvatar(
            profileId: userId,
            imageUrl: profileImageUrl,
          ),
          contentPadding: const EdgeInsets.only(
            left: AppSizes.bodyHorizontalPadding / 2,
          ),
          title: name,
          titleStyle: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
              fontSize:
                  (Theme.of(context).listTileTheme.titleTextStyle?.fontSize ??
                          16) *
                      1.2),
          subtitle: subtitle,
          verticalSpacing: AppSizes.bodyVerticalPadding,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.qr_code),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
