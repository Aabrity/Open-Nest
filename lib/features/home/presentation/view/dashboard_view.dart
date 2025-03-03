// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/core/theme/app_theme.dart';
// import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
// import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
// import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class DashboardView extends StatelessWidget {
//   const DashboardView({super.key});

// @override
//   void initState() {
//     super.initState();
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       if (event.x.abs() > 12 || event.y.abs() > 12 || event.z.abs() > 12) {
//         _showLogoutConfirmationDialog(context);
//       }
//     });
//   }

//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Logout'),
//           content: const Text('Are you sure you want to log out?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 showMySnackBar(
//                       context: context,
//                       message: 'Logging out...',
//                       color: Colors.red,
//                     );
//                     context.read<DashboardCubit>().logout(context);
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
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
//             elevation: 0,
//             backgroundColor: AppTheme.appBarBackgroundColor,
//             toolbarHeight: screenHeight * 0.12,
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   radius: screenHeight * 0.04,
//                   backgroundImage: const AssetImage('assets/images/profile.png'),
//                 ),
//                 SizedBox(width: screenWidth * 0.03),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome,',
//                       style: TextStyle(
//                         fontSize: fontSize * 0.8,
//                         color: AppTheme.appBarTextColor,
//                       ),
//                     ),
//                     Text(
//                       'Anamika',
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
//   @override
//   void initState() {
//     super.initState();
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       if (event.x.abs() > 12 || event.y.abs() > 12 || event.z.abs() > 12) {
//         _showLogoutConfirmationDialog(context);
//       }
//     });
//   }

//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Logout'),
//           content: const Text('Are you sure you want to log out?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 showMySnackBar(
//                       context: context,
//                       message: 'Logging out...',
//                       color: Colors.red,
//                     );
//                     context.read<DashboardCubit>().logout(context);
//               },
//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );
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
//             elevation: 0,
//             backgroundColor: AppTheme.appBarBackgroundColor,
//             toolbarHeight: screenHeight * 0.12,
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   radius: screenHeight * 0.04,
//                   backgroundImage: const AssetImage('assets/images/profile.png'),
//                 ),
//                 SizedBox(width: screenWidth * 0.03),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome,',
//                       style: TextStyle(
//                         fontSize: fontSize * 0.8,
//                         color: AppTheme.appBarTextColor,
//                       ),
//                     ),
//                     Text(
//                       'Anamika',
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
//                     _showLogoutConfirmationDialog(context);
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
//   final double _shakeThreshold = 2.5; 
//   DateTime? _lastShakeTime;

//   @override
//   void initState() {
//     super.initState();
//     _startAccelerometer();
//   }

//   void _startAccelerometer() {
//     userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       final double acceleration = _calculateAcceleration(event);
//       if (acceleration > _shakeThreshold) {
//         final now = DateTime.now();
//         if (_lastShakeTime == null || now.difference(_lastShakeTime!) > const Duration(seconds: 2)) {
//           _lastShakeTime = now;
//           _onShakeDetected();
//         }
//       }
//     });
//   }

//   double _calculateAcceleration(UserAccelerometerEvent event) {
//     return (event.x * event.x + event.y * event.y + event.z * event.z);
//   }

//   void _onShakeDetected() {
//     showMySnackBar(
//       context: context,
//       message: 'Shake detected. Logging out...',
//       color: Colors.red,
//     );
//     context.read<DashboardCubit>().logout(context);
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
//             elevation: 0,
//             backgroundColor: AppTheme.appBarBackgroundColor,
//             toolbarHeight: screenHeight * 0.12,
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   radius: screenHeight * 0.04,
//                   backgroundImage: const AssetImage('assets/images/profile.png'),
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
//                       'Open-Nest',
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
//   final double _tiltThreshold = 6.0;
//   @override
//   void initState() {
//     super.initState();
//     _startGyroscope();
//   }

//   void _startGyroscope() {
//     gyroscopeEvents.listen((GyroscopeEvent event) {
//       if (event.y > _tiltThreshold) {
//         _navigateRight();
//       } else if (event.y < -_tiltThreshold) {
//         _navigateLeft();
//       }
//     });
//   }

//   void _navigateRight() {
//     final cubit = context.read<DashboardCubit>();
//     final newIndex = (cubit.state.selectedIndex + 1) % cubit.state.views.length;
//     cubit.onTabTapped(newIndex);
//   }

//   void _navigateLeft() {
//     final cubit = context.read<DashboardCubit>();
//     final newIndex = (cubit.state.selectedIndex - 1 + cubit.state.views.length) % cubit.state.views.length;
//     cubit.onTabTapped(newIndex);
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
//             elevation: 0,
//             backgroundColor: AppTheme.appBarBackgroundColor,
//             toolbarHeight: screenHeight * 0.12,
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   radius: screenHeight * 0.04,
//                   backgroundImage: const AssetImage('assets/images/profile.png'),
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
//                       'Open-Nest',
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/core/theme/app_theme.dart';
import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_cubit.dart';
import 'package:open_nest/features/home/presentation/view_model/dashboard_state.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
                      'Welcome To,',
                      style: TextStyle(
                        fontSize: fontSize * 0.8,
                        color: AppTheme.appBarTextColor,
                      ),
                    ),
                    Text(
                      'Open-Nest',
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

