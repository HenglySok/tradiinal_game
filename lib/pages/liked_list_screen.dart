import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'detail_screen.dart';

class LikedListScreen extends StatelessWidget {
  const LikedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final likedGames = Provider.of<UserProvider>(context).likedGames;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff800000), // Dark Red
        title: const Text(
          "ល្បែងដែលចូលចិត្ត",
          style: TextStyle(color: Color(0xffFFD700)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: likedGames.isEmpty
          ? const Center(child: Text("មិនទាន់មានល្បែងដែលចូលចិត្តនៅឡើយទេ"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: likedGames.length,
              itemBuilder: (context, index) {
                final game = likedGames[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(game: game),
                    ),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      game.imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    game.nameKh,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                );
              },
            ),
    );
  }
}
