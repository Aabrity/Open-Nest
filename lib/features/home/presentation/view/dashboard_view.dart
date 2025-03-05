

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/core/theme/app_theme.dart';
// import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
// import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
// import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   final double _tiltThreshold = 2.0;
//   bool _canNavigate = true;

//   @override
//   void initState() {
//     super.initState();
//     _startGyroscope();
//   }

//   void _startGyroscope() {
//     gyroscopeEvents.listen((GyroscopeEvent event) {
//       if (event.y > _tiltThreshold && _canNavigate) {
//         _navigateRight();
//         _canNavigate = false;
//         Future.delayed(const Duration(seconds: 1), () {
//           _canNavigate = true;
//         });
//       }
//     });
//   }

//   void _navigateRight() {
//     final cubit = context.read<DashboardCubit>();
//     final currentIndex = cubit.state.selectedIndex;
//     final nextIndex = (currentIndex + 1) % cubit.state.views.length;
//     cubit.onTabTapped(nextIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final orientation = MediaQuery.of(context).orientation;

//     double fontSize = orientation == Orientation.portrait
//         ? screenHeight * 0.025
//         : screenHeight * 0.05;
//     double iconSize = orientation == Orientation.portrait
//         ? screenHeight * 0.03
//         : screenHeight * 0.06;

//     return BlocBuilder<DashboardCubit, DashboardState>(
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: AppTheme.backgroundColor,
//           appBar: AppBar(
//             elevation: 1.5,
//             shadowColor: Colors.orangeAccent,
//             backgroundColor: Colors.white,
//             toolbarHeight: screenHeight * 0.12,
//             title: Row(
//               children: [
//                Container(
//   width: screenHeight * 0.08, // Diameter of the circle
//   height: screenHeight * 0.08,
//   decoration: BoxDecoration(
//     shape: BoxShape.circle,
//     border: Border.all(color: Colors.orange, width: 2.5),
//   ),
//   child: CircleAvatar(
//     radius: screenHeight * 0.04,
//     backgroundColor: Colors.white,
//     backgroundImage: const AssetImage('assets/images/profile.png'),
//   ),
// ),

//                 SizedBox(width: screenWidth * 0.03),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome To,',
//                       style: TextStyle(
//                         fontSize: fontSize * 0.8,
//                         color: AppTheme.appBarTextColor,
//                       ),
//                     ),
//                     Text(
//                       '      Open-Nest',
//                       style: TextStyle(
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   icon: const Icon(Icons.logout),
//                   onPressed: () {
//                     showMySnackBar(
//                       context: context,
//                       message: 'Logging out...',
//                       color: Colors.red,
//                     );
//                     context.read<DashboardCubit>().logout(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           body: state.views[state.selectedIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//               BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add'),
//               BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.white,
//             onTap: (index) {
//               context.read<DashboardCubit>().onTabTapped(index);
//             },
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//           floatingActionButton: _buildFloatingNavBar(context),
//         );
//       },
//     );
//   }

//   Widget _buildFloatingNavBar(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 9.0),
//       padding: const EdgeInsets.all(0),
//       decoration: BoxDecoration(
//         color: AppTheme.secondaryColor,
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             spreadRadius: 2,
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: BottomAppBar(
//         color: Colors.transparent,
//         elevation: 0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildNavItem(context, Icons.home, "Home", 0),
//             _buildNavItem(context, Icons.search, "Search", 1),
//             _buildNavItem(context, Icons.add_circle_outline, "Add", 2),
//             _buildNavItem(context, Icons.person, "Profile", 3),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
//     final isSelected = context.watch<DashboardCubit>().state.selectedIndex == index;

//     return GestureDetector(
//       onTap: () {
//         context.read<DashboardCubit>().onTabTapped(index);
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 25,
//             color: isSelected ? AppTheme.primaryColor : AppTheme.appBarBackgroundColor,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 15,
//               color: isSelected ? AppTheme.primaryColor : AppTheme.appBarBackgroundColor,
//             ),
//           ),
//           if (isSelected)
//             Container(
//               margin: const EdgeInsets.only(top: 4),
//               width: 6,
//               height: 6,
//               decoration: const BoxDecoration(
//                 color: Colors.orange,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/core/theme/app_theme.dart';
// import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
// import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
// import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   final double _tiltThreshold = 2.0;
//   bool _canNavigate = true;

//   @override
//   void initState() {
//     super.initState();
//     _startGyroscope();
//   }

//   void _startGyroscope() {
//     gyroscopeEvents.listen((GyroscopeEvent event) {
//       if (event.y > _tiltThreshold && _canNavigate) {
//         _navigateRight();
//         _canNavigate = false;
//         Future.delayed(const Duration(seconds: 1), () {
//           _canNavigate = true;
//         });
//       }
//     });
//   }

//   void _navigateRight() {
//     final cubit = context.read<DashboardCubit>();
//     final currentIndex = cubit.state.selectedIndex;
//     final nextIndex = (currentIndex + 1) % cubit.state.views.length;
//     cubit.onTabTapped(nextIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final orientation = MediaQuery.of(context).orientation;

//     double fontSize = orientation == Orientation.portrait
//         ? screenHeight * 0.025
//         : screenHeight * 0.05;
//     double iconSize = orientation == Orientation.portrait
//         ? screenHeight * 0.03
//         : screenHeight * 0.06;

//     // Adjust layout based on screen size (Tablet or Phone)
//     bool isTablet = screenWidth > 600;

//     return BlocBuilder<DashboardCubit, DashboardState>(
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: AppTheme.backgroundColor,
//           appBar: AppBar(
//             elevation: 1.5,
//             shadowColor: Colors.orangeAccent,
//             backgroundColor: Colors.white,
//             toolbarHeight: screenHeight * 0.12,
//             title: Row(
//               children: [
//                 Container(
//                   width: screenHeight * 0.08, // Diameter of the circle
//                   height: screenHeight * 0.08,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.orange, width: 2.5),
//                   ),
//                   child: CircleAvatar(
//                     radius: screenHeight * 0.04,
//                     backgroundColor: Colors.white,
//                     backgroundImage: const AssetImage('assets/images/profile.png'),
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.03),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome To,',
//                       style: TextStyle(
//                         fontSize: fontSize * 0.8,
//                         color: AppTheme.appBarTextColor,
//                       ),
//                     ),
//                     Text(
//                       '      Open-Nest',
//                       style: TextStyle(
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   icon: const Icon(Icons.logout),
//                   onPressed: () {
//                     showMySnackBar(
//                       context: context,
//                       message: 'Logging out...',
//                       color: Colors.red,
//                     );
//                     context.read<DashboardCubit>().logout(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           body: state.views[state.selectedIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//               BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add'),
//               BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.white,
//             onTap: (index) {
//               context.read<DashboardCubit>().onTabTapped(index);
//             },
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//           floatingActionButton: _buildFloatingNavBar(context, isTablet),
//         );
//       },
//     );
//   }

//   Widget _buildFloatingNavBar(BuildContext context, bool isTablet) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 9.0),
//       padding: const EdgeInsets.all(0),
//       decoration: BoxDecoration(
//         color: AppTheme.secondaryColor,
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.4),
//             spreadRadius: 2,
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: BottomAppBar(
//         color: Colors.transparent,
//         elevation: 0,
//         child: Row(
//           mainAxisAlignment: isTablet
//               ? MainAxisAlignment.spaceEvenly
//               : MainAxisAlignment.spaceBetween,
//           children: [
//             _buildNavItem(context, Icons.home, "Home", 0),
//             _buildNavItem(context, Icons.search, "Search", 1),
//             _buildNavItem(context, Icons.add_circle_outline, "Add", 2),
//             _buildNavItem(context, Icons.person, "Profile", 3),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
//     final isSelected = context.watch<DashboardCubit>().state.selectedIndex == index;

//     return GestureDetector(
//       onTap: () {
//         context.read<DashboardCubit>().onTabTapped(index);
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 25,
//             color: isSelected ? AppTheme.primaryColor : AppTheme.appBarBackgroundColor,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 15,
//               color: isSelected ? AppTheme.primaryColor : AppTheme.appBarBackgroundColor,
//             ),
//           ),
//           if (isSelected)
//             Container(
//               margin: const EdgeInsets.only(top: 4),
//               width: 6,
//               height: 6,
//               decoration: const BoxDecoration(
//                 color: Colors.orange,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/core/theme/app_theme.dart'; // Custom theme
import 'package:open_nest/core/common/snackbar/my_snackbar.dart'; // Snackbar utility
import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart'; // DashboardCubit for state management
import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart'; // DashboardState
import 'package:sensors_plus/sensors_plus.dart'; // Gyroscope functionality (if you're using it)
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final double _tiltThreshold = 2.0;
  bool _canNavigate = true;

  @override
  void initState() {
    super.initState();
    _startGyroscope();
  }

  void _startGyroscope() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (event.y > _tiltThreshold && _canNavigate) {
        _navigateRight();
        _canNavigate = false;
        Future.delayed(const Duration(seconds: 1), () {
          _canNavigate = true;
        });
      }
    });
  }

  void _navigateRight() {
    final cubit = context.read<DashboardCubit>();
    final currentIndex = cubit.state.selectedIndex;
    final nextIndex = (currentIndex + 1) % cubit.state.views.length;
    cubit.onTabTapped(nextIndex);
  }

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

    // Adjust layout based on screen size (Tablet or Phone)
    bool isTablet = screenWidth > 600;

    // Adjust font size based on tablet or phone
    double titleFontSize = isTablet ? screenHeight * 0.03 : fontSize;
    double subtitleFontSize = isTablet ? screenHeight * 0.02 : fontSize * 0.8;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            elevation: 1.5,
            shadowColor: Colors.orangeAccent,
            backgroundColor: Colors.white,
            toolbarHeight: screenHeight * 0.12,
            title: Row(
              children: [
                Container(
                  width: screenHeight * 0.08, // Diameter of the circle
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange, width: 2.5),
                  ),
                  child: CircleAvatar(
                    radius: screenHeight * 0.04,
                    backgroundColor: Colors.white,
                    backgroundImage: const AssetImage('assets/images/profile.png'),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome To,',
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        color: AppTheme.appBarTextColor,
                      ),
                    ),
                    Text(
                      '      Open-Nest',
                      style: TextStyle(
                        fontSize: titleFontSize,
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
          floatingActionButton: _buildFloatingNavBar(context, isTablet),
        );
      },
    );
  }

  Widget _buildFloatingNavBar(BuildContext context, bool isTablet) {
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
          mainAxisAlignment: isTablet
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
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

