import 'package:flutter/material.dart';

class SignInViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Perform validation and sign-in logic
  Future<String?> signIn() async {
    // Validate email and password
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return "Please fill in all fields";
    }

    if (!_validateEmail(emailController.text)) {
      return "Invalid email format";
    }

    // Simulate a network call or async operation (e.g., sign-in API)
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // If everything is valid, return null (or success message)
    return null; // Return null for success
  }

  // Email validation method
  bool _validateEmail(String email) {
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
