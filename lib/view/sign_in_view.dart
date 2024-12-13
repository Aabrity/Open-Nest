import 'package:flutter/material.dart';
import 'package:open_nest/view/register_view.dart';
import '../viewmodel/sign_in_viewmodel.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInViewModel _viewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: isLandscape ? screenHeight * 0.05 : 0,
                bottom: isLandscape ? screenHeight * 0.05 : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with modernized style
                  Container(
                    height: isLandscape ? screenHeight * 0.3 : screenHeight * 0.15,
                    width: isLandscape ? screenWidth * 0.2 : screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo.png'), // Replace with your logo asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: isLandscape ? screenHeight * 0.05 : screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Sign in to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      children: [
                        // Modernized Text Fields with Floating Labels
                        _buildModernTextField(
                          controller: _viewModel.emailController,
                          labelText: "Email",
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        _buildModernTextField(
                          controller: _viewModel.passwordController,
                          labelText: "Password",
                          isPassword: true,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(screenHeight * 0.02),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () async {
                              String? errorMessage = await _viewModel.signIn();
                              if (errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              }
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: isLandscape ? screenHeight * 0.05 : screenHeight * 0.025,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
                              ),
                            ),
                             GestureDetector(
                          onTap: () {
                            // Navigate to RegisterView when clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterView()),
                            );
                          },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modernized Text Field Widget with Floating Label
  Widget _buildModernTextField({
    required TextEditingController controller,
    required String labelText,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        labelStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 16.0,
        ),
      ),
      style: const TextStyle(fontSize: 16.0),
    );
  }
}
