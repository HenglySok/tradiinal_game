import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/providers/user_provider.dart';
import 'package:tradinal_game/pages/auth/login_screen.dart';
import 'package:tradinal_game/pages/saved_list_screen.dart'; // Create these pages
import 'package:tradinal_game/pages/liked_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the UserProvider for data changes
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
            color: Color(0xff800000), // Dark Red
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffA2D149), // Green
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

          // --- MENU TILES WITH DYNAMIC COUNTS ---
          _buildMenuTile(
            Icons.save_outlined,
            "រក្សាទុក",
            userProv.savedGames.length.toString(), // Display count
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedListScreen()),
            ),
          ),

          _buildMenuTile(
            Icons.favorite_outline,
            "ចូលចិត្ត",
            userProv.likedGames.length.toString(),
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LikedListScreen()),
            ),
          ),

          _buildMenuTile(
            Icons.logout,
            "log out",
            null,
            () => _showLogoutDialog(context),
            isLogout: true,
          ),
        ],
      ),
    );
  }

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
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            ),
            child: const Text("ចាកចេញ", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    IconData icon,
    String title,
    String? count,
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
        // Add the count bubble/text if it exists
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (count != null)
              Text(
                count,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            const SizedBox(width: 10),
            if (!isLogout)
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 18,
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
