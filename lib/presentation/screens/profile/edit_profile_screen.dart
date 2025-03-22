import 'package:circlechat_app/core/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'dart:io';

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
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
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(
                'Name',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                _name.isEmpty ? _namePlaceholder : _name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
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
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                'About',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                _about.isEmpty ? _aboutPlaceholder : _about,
                style: Theme.of(context).textTheme.bodySmall,
              ),
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
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text(
                'Phone',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                'Your Phone Number',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () => UIHelpers.showEditBottomSheet(
                context,
                'Phone',
                'Your Phone Number',
                'Enter your phone number',
                (value) {
                  setState(() {
                    _about = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
