import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.12,
        title: Row(
          children: [
            CircleAvatar(
              radius: screenHeight * 0.04,
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
            SizedBox(width: screenWidth * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: screenHeight * 0.018,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Anamika',
                  style: TextStyle(
                    fontSize: screenHeight * 0.022,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.grey[700],
                size: screenHeight * 0.035,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea( // Ensuring content doesn't get blocked in landscape view
        child: SingleChildScrollView( // Make the body scrollable
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Stat cards (now responsive)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(
                      ' 12',
                      'Active Listings',
                      const Color.fromARGB(255, 74, 57, 48),
                      screenHeight,
                      screenWidth,
                      isLandscape
                    ),
                    _buildStatCard(
                      ' 5.3k',
                      'Total Likes',
                      const Color.fromARGB(255, 74, 57, 48),
                      screenHeight,
                      screenWidth,
                      isLandscape
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Adjusting the grid based on orientation
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
                  shrinkWrap: true, // Allow the grid to take up only the space it needs
                  crossAxisCount: isLandscape ? 4 : 2,  // 4 columns in landscape, 2 in portrait
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildActionTile(Icons.home, 'Browse Properties', const Color.fromARGB(255, 0, 0, 0), context, const BrowsePropertiesScreen(), isLandscape),
                    _buildActionTile(Icons.add_business, 'Add Listings', const Color.fromARGB(255, 0, 0, 0), context, const AddListingsScreen(), isLandscape),
                    _buildActionTile(Icons.edit, 'Manage Listings', const Color.fromARGB(255, 0, 0, 0), context, const ManageListingsScreen(), isLandscape),
                    _buildActionTile(Icons.message, 'Messages', const Color.fromARGB(255, 0, 0, 0), context, const MessagesScreen(), isLandscape),
                  ],
                ),
                // Adding padding to avoid the app bar blocking the content in landscape mode
                SizedBox(height: isLandscape ? screenHeight * 0.25 : 0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 10.0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, "Home", true),
              _buildNavItem(Icons.search, "Search", false),
              _buildNavItem(Icons.add_circle_outline, "Add", false),
              _buildNavItem(Icons.person, "Profile", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, double screenHeight, double screenWidth, bool isLandscape) {
    double cardWidth = isLandscape ? screenWidth * 0.4 : screenWidth * 0.45;
    return Container(
      width: cardWidth,  // Adjust the width based on orientation
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: screenHeight * 0.02,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: screenHeight * 0.0),
          Text(
            title,
            style: TextStyle(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String label, Color color, BuildContext context, Widget destination, bool isLandscape) {
    double cardWidth = isLandscape ? 150 : 200;  // Smaller width for landscape mode
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        width: cardWidth,  // Adjust the width based on orientation
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Icon(icon, size: 45, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.orange : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class BrowsePropertiesScreen extends StatelessWidget {
  const BrowsePropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Properties')),
      body: const Center(child: Text('Browse Properties Page')),
    );
  }
}

class AddListingsScreen extends StatelessWidget {
  const AddListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Listings')),
      body: const Center(child: Text('Add Listings Page')),
    );
  }
}

class ManageListingsScreen extends StatelessWidget {
  const ManageListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Listings')),
      body: const Center(child: Text('Manage Listings Page')),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: const Center(child: Text('Messages Page')),
    );
  }
}
