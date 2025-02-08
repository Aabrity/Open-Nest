import 'package:flutter/material.dart';

class SignInViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Perform sign-in logic and navigate on success
  Future<String?> signIn(BuildContext context) async {
    // Validate inputs
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return "Please fill in all fields";
    }

    if (!_validateEmail(emailController.text)) {
      return "Invalid email format";
    }

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock logic: success for specific email/password
    if (emailController.text == "Anamika@example.com" &&
        passwordController.text == "password123") {
      // Ensure the widget is still mounted before navigating
      if (context.mounted) {
        // Navigate to the Dashboard on success
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
      return null; // Success
    } else {
      return "Invalid email or password"; // Failure
    }
  }

  // Email validation method
  bool _validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
