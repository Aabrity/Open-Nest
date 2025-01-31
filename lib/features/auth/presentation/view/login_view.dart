import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/auth/presentation/view/register_view.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'user');
  final _passwordController = TextEditingController(text: 'user123');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN IN'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: isLandscape ? screenHeight * 0.25 : screenHeight * 0.1,
                    width: isLandscape ? screenWidth * 0.15 : screenWidth * 0.3,
                    decoration: BoxDecoration(
                      
                      
                        color: Colors.blueGrey,
                        
                      
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Sign in to your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLandscape ? screenHeight * 0.03 : screenHeight * 0.017,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                LoginStudentEvent(
                                  context: context,
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      child: const Text(
                        "Sign In",
                         style: TextStyle(
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<LoginBloc>().add(
                                NavigateRegisterScreenEvent(
                                  destination: RegisterView(),
                                  context: context,
                                ),
                              );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator,
    );
  }
}
