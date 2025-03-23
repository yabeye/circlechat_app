import 'dart:io';
import 'package:circlechat_app/core/constants/app_sizes.dart';
import 'package:circlechat_app/core/locator.dart';
import 'package:circlechat_app/core/navigation/app_router.dart';
import 'package:circlechat_app/core/navigation/navigation_helper.dart';
import 'package:circlechat_app/core/utils/app_formatters.dart';
import 'package:circlechat_app/core/utils/size_utils.dart';
import 'package:circlechat_app/core/utils/ui_helpers.dart';
import 'package:circlechat_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_buttons.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:flutter/material.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_edit_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  String _name = '';
  final _namePlaceholder = 'Enter your name';
  String _about = 'I\'m using CirlceChat';
  final _aboutPlaceholder = 'Enter your About';
  File? _profileImage;

  Future<void> _chooseImage() async {
    final pickedImage = await UIHelpers.choosePhoto(
      context,
      title: 'Profile Photo',
      actionIcon: IconButton(
        icon: const Icon(
          Icons.delete_outline,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleSpacing: AppSizes.globalPadding,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              getIt<AuthCubit>().signOut();
              NavigationHelper.navigateTo(
                context,
                AppRouter.phoneAuth,
                replaceAll: true,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.bodyVerticalPadding,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: _chooseImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors.disabled.withAlpha(128),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.camera_alt_outlined,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AppListTile(
              leading: const Icon(Icons.person_outline),
              title: 'Name',
              subtitle: _name.isEmpty ? _namePlaceholder : _name,
              onTap: () => UIHelpers.showEditBottomSheet(
                context,
                'Name',
                _name,
                _namePlaceholder,
                (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
            ),
            AppListTile(
              leading: const Icon(Icons.info_outline),
              title: 'About',
              subtitle: _about.isEmpty ? _aboutPlaceholder : _about,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutEditScreen(
                    initialAbout: _about,
                    onAboutChanged: (newAbout) {
                      setState(() {
                        _about = newAbout;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                return AppListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: 'Phone',
                  subtitle: authState is Authenticated
                      ? AppFormatters.formatPhoneNumber(
                          authState.user?.phoneNumber ?? '')
                      : '',
                );
              },
            ),
            AppSizes.verticalPaddingMax,
            AppElevatedButton(
              height: 42,
              width: AppScreenUtils.width * .8,
              onPressed: () {
                NavigationHelper.navigateTo(
                  context,
                  AppRouter.home,
                  replaceAll: true,
                );
              },
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
