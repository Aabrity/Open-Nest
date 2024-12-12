import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:open_nest/view/sign_in_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

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
          child: Padding(
            padding: EdgeInsets.only(
              top: isLandscape ? screenHeight * 0.05 : 0,
              bottom: isLandscape ? screenHeight * 0.05 : 0,
            ),
            child: SingleChildScrollView( // Allow scrolling vertically, but avoid horizontal scrolling
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with the same style as RegisterView
                  Container(
                    height: isLandscape ? screenHeight * 0.25 : screenHeight * 0.15,
                    width: screenWidth * 0.3, // Restrict width in both modes
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0), // Slightly rounded edges
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
                    "Home is where the Heart is.",
                    style: TextStyle(
                      fontSize: isLandscape ? screenHeight * 0.05 : screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Looking for your nest birdie? You found the right place. Let us help!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Onboarding page content
                  SizedBox(
                    height: screenHeight * 0.45, // Adjusted to allow space for page content
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        _buildPage('assets/images/onboarding1.jpg', 'Welcome to OPEN NEST.'),
                        _buildPage('assets/images/onboarding2.jpg', 'Browse Properties Easily'),
                        _buildPage('assets/images/onboarding3.jpg', 'Manage Listings Efficiently'),
                        _buildPage('assets/images/onboarding4.jpg', 'Track Your Property Interests'),
                        _buildPage('assets/images/onboarding5.jpg', 'Connect with Agents Instantly'),
                      ],
                    ),
                  ),
                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 5,
                    effect: const ExpandingDotsEffect(activeDotColor: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  // Skip or Next button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: _currentPage == 4
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              backgroundColor: Colors.black, // Match the button style
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignInView()),
                              );
                            },
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: isLandscape ? screenHeight * 0.05 : screenHeight * 0.025,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              backgroundColor: Colors.black, // Match the button style
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: isLandscape ? screenHeight * 0.05 : screenHeight * 0.025,
                                color: Colors.white,
                              ),
                            ),
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

  // Helper function to create each onboarding page
  Widget _buildPage(String imagePath, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 250), // Adjust image size as needed
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
