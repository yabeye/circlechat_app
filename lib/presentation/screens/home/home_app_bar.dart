import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'CircleChat',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search_sharp),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          offset: const Offset(0, kToolbarHeight),
          onSelected: (String result) {
            switch (result) {
              case 'New Group':
                break;
              case 'New Community':
                break;
              case 'Starred Messages':
                break;
              case 'Settings':
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'New Group',
              child: Text('New Group'),
            ),
            const PopupMenuItem<String>(
              value: 'New Community',
              child: Text('New Community'),
            ),
            const PopupMenuItem<String>(
              value: 'Starred Messages',
              child: Text('Starred Messages'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
          ],
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
