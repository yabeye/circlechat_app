import 'package:circlechat_app/core/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';

class AboutEditScreen extends StatefulWidget {
  const AboutEditScreen({
    required this.initialAbout,
    required this.onAboutChanged,
    super.key,
  });

  final String initialAbout;
  final Function(String) onAboutChanged;

  @override
  AboutEditScreenState createState() => AboutEditScreenState();
}

class AboutEditScreenState extends State<AboutEditScreen> {
  late TextEditingController _aboutController;
  final List<String> _aboutSuggestions = [
    'Available',
    'Busy',
    'At the gym',
    'Sleeping',
    'At work',
  ];

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController(text: widget.initialAbout);
  }

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  Widget _buildAboutListTile({
    required String title,
    void Function()? onTap,
    Widget? trailing,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: textTheme.headlineSmall!.copyWith(
          color: Theme.of(context).iconTheme.color,
          fontSize: 16,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Currently set to',
              style: textTheme.bodySmall,
            ),
            _buildAboutListTile(
              title: widget.initialAbout,
              onTap: () => UIHelpers.showEditBottomSheet(
                context,
                'About',
                widget.initialAbout,
                '',
                (value) {
                  widget.onAboutChanged(value);
                },
              ),
              trailing: const IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                ),
                onPressed: null,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select About',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _aboutSuggestions.map((about) {
                return InkWell(
                  onTap: () {
                    // Corrected line: Trigger onAboutChanged
                    widget.onAboutChanged(about);
                    Navigator.pop(context); // Optional: Pop after selection
                  },
                  child: Chip(
                    label: Text(about),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
