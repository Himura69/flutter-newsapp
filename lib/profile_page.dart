// profile_page.dart

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFB0BEC5),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile picture and information
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                    'assets/Nizam Hukmul Kautsar.jpg'), // Ganti dengan gambar lokal Anda
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Nizam Hukmul Kautsar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                '220605110096@student.uin-malang.ac.id',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Profile Details in a Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(color: Colors.grey),
                    ListTile(
                      title: Text('Edit Profile'),
                      leading: Icon(Icons.edit, color: Colors.blue),
                      onTap: () {
                        // Handle edit profile action
                      },
                    ),
                    ListTile(
                      title: Text('Change Password'),
                      leading: Icon(Icons.lock, color: Colors.blue),
                      onTap: () {
                        // Handle change password action
                      },
                    ),
                    ListTile(
                      title: Text('Privacy Settings'),
                      leading: Icon(Icons.security, color: Colors.blue),
                      onTap: () {
                        // Handle privacy settings action
                      },
                    ),
                    Divider(color: Colors.grey),
                    ListTile(
                      title: Text('Logout'),
                      leading: Icon(Icons.logout, color: Colors.red),
                      onTap: () {
                        // Implement logout functionality
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
