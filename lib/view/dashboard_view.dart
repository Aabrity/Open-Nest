import 'package:flutter/material.dart';
import 'package:open_nest/core/app_theme/app_theme.dart';
import 'package:open_nest/view/add_screen.dart';
import 'package:open_nest/view/home_screen.dart';
import 'package:open_nest/view/profile_screen.dart';
import 'package:open_nest/view/search_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  int _selectedNavIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    double fontSize = orientation == Orientation.portrait ? screenHeight * 0.018 : screenHeight * 0.05;
    double iconSize = orientation == Orientation.portrait ? screenHeight * 0.03 : screenHeight * 0.06;

    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.appBarBackgroundColor,
          toolbarHeight: screenHeight * 0.12,
          title: Row(
            children: [
              CircleAvatar(
                radius: screenHeight * 0.04,
                backgroundImage: const AssetImage('assets/images/profile.png'),
              ),
              SizedBox(width: screenWidth * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      fontSize: fontSize * 0.8,
                      color: AppTheme.appBarTextColor,
                    ),
                  ),
                  Text(
                    'Anamika',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppTheme.notificationIconColor,
                  size: iconSize,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _selectedNavIndex,
            children: _screens,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 9.0),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home, "Home", 0),
                _buildNavItem(Icons.search, "Search", 1),
                _buildNavItem(Icons.add_circle_outline, "Add", 2),
                _buildNavItem(Icons.person, "Profile", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: _selectedNavIndex == index
                ? AppTheme.primaryColor
                : AppTheme.appBarBackgroundColor,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedNavIndex == index
                  ? AppTheme.primaryColor
                  : AppTheme.appBarBackgroundColor,
            ),
          ),
          if (_selectedNavIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
