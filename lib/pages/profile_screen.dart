import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/providers/user_provider.dart';
import 'package:tradinal_game/pages/auth/login_screen.dart'; // Ensure this path is correct

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    final String name = userProv.currentUserName;
    final String email = userProv.currentUserEmail;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "MY PROFILE",
          style: TextStyle(
            color: Color(0xff800000),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Color(0xff800000)),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffE0E0E0),
                  child: Icon(Icons.person, size: 80, color: Colors.black54),
                ),
                const SizedBox(height: 15),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.blue, fontSize: 14),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Profile Logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffA2D149),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // --- FIXED MENU ITEMS CALLS ---
          _buildMenuTile(Icons.save_outlined, "រក្សាទុក", () {
            // Logic for Save
          }),

          _buildMenuTile(Icons.favorite_outline, "ចូលចិត្ត", () {
            // Logic for Favorites
          }),

          _buildMenuTile(Icons.logout, "log out", () {
            // LOGIC: Functional Logout button
            _showLogoutDialog(context);
          }, isLogout: true),
        ],
      ),
    );
  }

  // LOGIC: Show confirmation before leaving
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("តើអ្នកចង់ចាកចេញមែនទេ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ទេ"),
          ),
          TextButton(
            onPressed: () {
              // Clears history and goes to Login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("ចាកចេញ", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Colors.black87,
          size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: isLogout
            ? null
            : const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 18,
              ),
        onTap: onTap,
      ),
    );
  }
}
