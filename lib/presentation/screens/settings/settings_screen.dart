import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/constants/asset_files.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          const Divider(),
          AppListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.disabled,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            title: 'Yeabsera',
            titleStyle: Theme.of(context)
                .listTileTheme
                .titleTextStyle!
                .copyWith(
                    fontSize: (Theme.of(context)
                                .listTileTheme
                                .titleTextStyle
                                ?.fontSize ??
                            16) *
                        1.2),
            horizontalTitleGap: 0,
            subtitle: 'Conversations happening.',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
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
          ),
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
    );
  }
}
