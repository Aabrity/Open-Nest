import 'package:flutter/material.dart';

class RegisterViewModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Perform mock registration
  Future<String?> register() async {
    // Validate inputs
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return "Please fill in all fields";
    }

    if (!_validateEmail(emailController.text)) {
      return "Invalid email format";
    }

    if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    }

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock logic: failure for a specific email
    if (emailController.text == "alreadyused@example.com") {
      return "Email is already registered"; // Simulate failure for existing email
    }

    // Mock success
    return null; // Success
  }

  // Email validation method
  bool _validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
