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
    final paddingTop = MediaQuery.of(context).padding.top;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isLandscape ? screenHeight * 0.02 : screenHeight * 0.02,
                horizontal: isLandscape ? screenWidth * 0.05 : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  Padding(
                    padding: EdgeInsets.only(top: paddingTop + 6.0),
                    child: Container(
                      height: isLandscape ? screenHeight * 0.3 : screenHeight * 0.15,
                      width: isLandscape ? screenWidth * 0.2 : screenWidth * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
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
                      fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                    child: Text(
                      "Looking for your nest birdie? You found the right place. Let us help!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isLandscape ? screenHeight * 0.03 : screenHeight * 0.02,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Onboarding Pages
                  SizedBox(
                    height: isLandscape ? screenHeight * 0.8 : screenHeight * 0.48,
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
                  // Page Indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 5,
                    effect: const ExpandingDotsEffect(activeDotColor: Colors.blue),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Navigation Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignInView()),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == 4 ? "Get Started" : "Next",
                        style: TextStyle(
                          fontSize: isLandscape ? screenHeight * 0.04 : screenHeight * 0.02,
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

  Widget _buildPage(String imagePath, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0), // Curved corners
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover, // Cover the entire width
          ),
        ),
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
