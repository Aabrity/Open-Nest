import 'package:flutter/material.dart';

class RegisterViewModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Perform validation and registration logic
  Future<String?> register() async {
    // Validate name, email, password, and confirm password
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

    // Simulate a network call or async operation (e.g., registration API)
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