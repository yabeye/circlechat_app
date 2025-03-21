import 'package:flutter/material.dart';
import 'package:circlechat_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Chats'),
    Text('Status'),
    Text('Communities'),
    Text('Calls'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
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
          // Communities
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
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: AppColors.primary.withValues(alpha: 0.2),
      ),
    );
  }
}
