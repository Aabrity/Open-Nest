import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder user data
    final Map<String, String> placeholderUser = {
      'userId': '12345',
      'email': 'user@example.com',
      'username': 'john_doe',
    };

    return Scaffold(
      body: Container(
        color: Colors.grey[50], // Light gray background
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Picture
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/profile_placeholder.png'), // Add a placeholder image in your assets
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // User Name
                Text(
                  placeholderUser['username']!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                // User Email
                Text(
                  placeholderUser['email']!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                // User Info Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // User ID
                      _buildInfoRow(Icons.person_outline, 'User ID', placeholderUser['userId']!),
                      const SizedBox(height: 15),
                      // Divider
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 15),
                      // Email
                      _buildInfoRow(Icons.email_outlined, 'Email', placeholderUser['email']!),
                      const SizedBox(height: 15),
                      // Divider
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 15),
                      // Username
                      _buildInfoRow(Icons.verified_user_outlined, 'Username', placeholderUser['username']!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a row with icon, title, and value
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey[600], size: 24),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}