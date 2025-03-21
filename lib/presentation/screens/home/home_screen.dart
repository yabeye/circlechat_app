import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static const List<Widget> _homePages = <Widget>[
    Center(child: Text('Chats')),
    Center(child: Text('Status')),
    Center(child: Text('Communities')),
    Center(child: Text('Calls')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            icon: const Icon(Icons.search_sharp),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            offset: const Offset(0, kToolbarHeight * .2),
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
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _homePages,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
