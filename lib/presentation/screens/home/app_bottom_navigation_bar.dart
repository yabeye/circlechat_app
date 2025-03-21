import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  final int selectedIndex;
  final void Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.chat_sharp),
          icon: Icon(Icons.chat_outlined),
          label: 'Chats',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.circle_notifications_sharp),
          icon: Icon(Icons.circle_notifications_outlined),
          label: 'Status',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.group_sharp),
          icon: Icon(Icons.group_outlined),
          label: 'Communities',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.call_sharp),
          icon: Icon(Icons.call_outlined),
          label: 'Calls',
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      indicatorColor: AppColors.primary.withValues(alpha: 0.2),
    );
  }
}
