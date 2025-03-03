import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/auth/presentation/view/login_view.dart';
import 'package:open_nest/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:open_nest/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key, required this.loginBloc});

  final PageController _controller = PageController();
  final LoginBloc loginBloc;
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingTop = MediaQuery.of(context).padding.top;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocProvider(
      create: (_) => OnboardingCubit(loginBloc),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isLandscape
                      ? screenHeight * 0.02
                      : screenHeight * 0.02,
                  horizontal: isLandscape ? screenWidth * 0.05 : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container
                    Padding(
                      padding: EdgeInsets.only(top: paddingTop + 6.0),
                      child: Container(
                        height: isLandscape
                            ? screenHeight * 0.3
                            : screenHeight * 0.15,
                        width:
                            isLandscape ? screenWidth * 0.2 : screenWidth * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          
                            color: Colors.white,
                            
                          
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Main Heading
                    Text(
                      "Home is where the Heart is.",
                      style: TextStyle(
                        fontSize: isLandscape
                            ? screenHeight * 0.04
                            : screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Subtitle
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                      child: Text(
                        "Looking for your nest birdie? You found the right place. Let us help!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isLandscape
                              ? screenHeight * 0.03
                              : screenHeight * 0.02,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    // Onboarding Pages
                    SizedBox(
                      height: isLandscape
                          ? screenHeight * 0.8
                          : screenHeight * 0.45,
                      child: BlocBuilder<OnboardingCubit, int>(
                        builder: (context, currentPage) {
                          return PageView(
                            controller: _controller,
                            onPageChanged: (index) {
                              context.read<OnboardingCubit>().goToPage(index);
                            },
                            children: [
                              _buildPage('assets/images/house.png',
                                  'Welcome to OPEN NEST.'),
                              _buildPage('assets/images/house3.png',
                                  'Browse Properties Easily'),
                              _buildPage('assets/images/house 2.png',
                                  'Manage Listings Efficiently'),
                              _buildPage('assets/images/house4.png',
                                  'Track Your Property Interests'),
                              _buildPage('assets/images/house 5.png',
                                  'Connect with Agents Instantly'),
                            ],
                          );
                        },
                      ),
                    ),
                    // Page Indicator
                    BlocBuilder<OnboardingCubit, int>(
                      builder: (context, currentPage) {
                        return SmoothPageIndicator(
                          controller: _controller,
                          count: 5,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: Colors.blue),
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    // Navigation Button
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                      child: BlocBuilder<OnboardingCubit, int>(
                        builder: (context, currentPage) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              if (context
                                  .read<OnboardingCubit>()
                                  .isLastPage()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider.value(
                                      value: loginBloc,
                                      child:  LoginView(), // Fixed naming
                                    ),
                                  ),
                                );
                              } else {
                                context.read<OnboardingCubit>().goToNextPage();
                                _controller.nextPage(
                                  duration:
                                      const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              currentPage == 4 ? "Get Started" : "Next",
                              style: TextStyle(
                                fontSize: isLandscape
                                    ? screenHeight * 0.04
                                    : screenHeight * 0.02,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 310,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
