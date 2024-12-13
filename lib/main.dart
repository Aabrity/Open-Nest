import 'package:flutter/material.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(), // Set OnboardingScreen as the home
      routes: {
        '/signin': (context) => const SignInView(), // Define your HomePage here
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
