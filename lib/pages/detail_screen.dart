import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_model.dart';
import '../providers/user_provider.dart'; // Ensure this exists

class DetailScreen extends StatelessWidget {
  final TraditionalGame game;
  const DetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Watch the UserProvider for changes in like/save status
    final userProvider = Provider.of<UserProvider>(context);
    final bool isSaved = userProvider.isSaved(game.id);
    final bool isLiked = userProvider.isLiked(game.id);

    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF800000), // Dark Red
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          game.nameKh,
          style: const TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),

            // Interaction Bar: Like and Save
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => userProvider.toggleSave(game),
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: const Color(0xFF800000), // Match App Bar
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () => userProvider.toggleLike(game),
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("១. ប្រវត្តិរូប"),
                  _buildContentText(game.description.history),
                  _buildSectionTitle("២. ពេលវេលា និងទីកន្លែងលេង"),
                  _buildBulletPoint(
                    "ពេលវេលា៖ ${game.description.timePlace['time']}",
                  ),
                  _buildBulletPoint(
                    "ទីកន្លែង៖ ${game.description.timePlace['place']}",
                  ),
                  _buildSectionTitle("៣. សម្ភារៈសម្រាប់លេង"),
                  ...game.description.materials.values.map(
                    (m) => _buildBulletPoint(m),
                  ),
                  _buildSectionTitle("៤. របៀបលេង"),
                  ...game.description.howToPlay.values.map(
                    (step) => _buildBulletPoint(step),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          game.imagePath,
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17, height: 1.7, color: Colors.black87),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 17, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
