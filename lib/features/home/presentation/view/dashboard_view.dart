import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/core/theme/app_theme.dart';
import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    double fontSize = orientation == Orientation.portrait
        ? screenHeight * 0.025
        : screenHeight * 0.05;
    double iconSize = orientation == Orientation.portrait
        ? screenHeight * 0.03
        : screenHeight * 0.06;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
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
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    showMySnackBar(
                      context: context,
                      message: 'Logging out...',
                      color: Colors.red,
                    );
                    context.read<DashboardCubit>().logout(context);
                  },
                ),
              ],
            ),
          ),
          body: state.views[state.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.white,
            onTap: (index) {
              context.read<DashboardCubit>().onTabTapped(index);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingNavBar(context),
        );
      },
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    return Container(
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
            _buildNavItem(context, Icons.home, "Home", 0),
            _buildNavItem(context, Icons.search, "Search", 1),
            _buildNavItem(context, Icons.add_circle_outline, "Add", 2),
            _buildNavItem(context, Icons.person, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = context.watch<DashboardCubit>().state.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        context.read<DashboardCubit>().onTabTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: isSelected ? AppTheme.primaryColor : AppTheme.appBarBackgroundColor,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isSelected ? AppTheme.primaryColor : AppTheme.appBarBackgroundColor,
            ),
          ),
          if (isSelected)
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
