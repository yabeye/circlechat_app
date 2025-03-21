import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class UIHelpers {
  static void showEditBottomSheet(
    BuildContext context,
    String title,
    String initialValue,
    String placeholder,
    Function(String) onSave, {
    bool allowEmpty = true,
  }) {
    String newValue = initialValue;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit $title',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: initialValue,
                  onChanged: (value) => newValue = value,
                  maxLength: 120,
                  autofocus: true,
                  decoration: InputDecoration(
                    // labelText: ,
                    hintText: placeholder,
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          if (allowEmpty && newValue.isEmpty) {
                            UIHelpers.showToast('$title can\'t be empty');
                            return;
                          }

                          onSave(newValue);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // TODO: Add an edit profile photo before upload option
  static Future<File?> choosePhoto(
    BuildContext context, {
    String title = 'Choose Photo',
    Widget? actionIcon,
  }) async {
    final picker = ImagePicker();

    return showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close_sharp,
                      color: Theme.of(context).iconTheme.color?.withValues(
                            alpha: .5,
                          ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  actionIcon ?? const SizedBox(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    _buildImageOption(
                      context: context,
                      icon: Icons.camera_alt_outlined,
                      label: 'Camera',
                      onTap: () async {
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.camera);
                        if (pickedFile != null) {
                          Navigator.pop(context, File(pickedFile.path));
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    _buildImageOption(
                      context: context,
                      icon: Icons.image_outlined,
                      label: 'Gallery',
                      onTap: () async {
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          Navigator.pop(context, File(pickedFile.path));
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    _buildImageOption(
                      context: context,
                      icon: Icons.account_circle_outlined,
                      label: 'Avatar',
                      onTap: () {
                        // TODO: Implement Avatar selection logic
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildImageOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 32),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: .3),
                  ),
                ),
                child: Icon(icon, size: 30, color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[300],
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
