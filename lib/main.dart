import 'package:flutter/material.dart';
import 'package:open_nest/core/app_theme/app_theme.dart';
import 'package:open_nest/view/dashboard_view.dart';
import 'package:open_nest/view/onboarding_screen_view.dart';
import 'package:open_nest/view/sign_in_view.dart';
import 'view/register_view.dart';
import 'viewmodel/register_viewmodel.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate App',
      theme: AppTheme.theme,
     
      home: const DashboardScreen(), 
      routes: {
        '/signin': (context) => const SignInView(),
        '/dashboard': (context) => const DashboardScreen() 
      },
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home Page")),
//       body: Center(child: Text("Welcome to Real Estate App!")),
//     );
//   }
// }
