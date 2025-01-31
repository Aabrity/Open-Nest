import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/core/theme/app_theme.dart';
import 'package:open_nest/features/home/presentation/view/bottom_view/account_view.dart';
import 'package:open_nest/features/home/presentation/view/bottom_view/add_view.dart';
import 'package:open_nest/features/home/presentation/view/bottom_view/home_view.dart';
import 'package:open_nest/features/home/presentation/view/bottom_view/search_view.dart';
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
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return IndexedStack(
              index: state.selectedNavIndex,
              children: const [
                HomeScreen(),
                SearchView(),
                AddView(),
                AccountView(),
              ],
            );
          },
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
              _buildNavItem(context, Icons.home, "Home", 0),
              _buildNavItem(context, Icons.search, "Search", 1),
              _buildNavItem(context, Icons.add_circle_outline, "Add", 2),
              _buildNavItem(context, Icons.person, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        context.read<DashboardCubit>().selectNavIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: context.watch<DashboardCubit>().state.selectedNavIndex == index
                ? AppTheme.primaryColor
                : AppTheme.appBarBackgroundColor,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: context.watch<DashboardCubit>().state.selectedNavIndex == index
                  ? AppTheme.primaryColor
                  : AppTheme.appBarBackgroundColor,
            ),
          ),
          if (context.watch<DashboardCubit>().state.selectedNavIndex == index)
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
