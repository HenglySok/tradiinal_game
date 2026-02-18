import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'detail_screen.dart';

class SavedListScreen extends StatelessWidget {
  const SavedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savedGames = Provider.of<UserProvider>(context).savedGames;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff800000),
        title: const Text(
          "បញ្ជីរក្សាទុក",
          style: TextStyle(color: Color(0xffFFD700)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: savedGames.isEmpty
          ? const Center(child: Text("មិនទាន់មានការរក្សាទុកនៅឡើយទេ"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedGames.length,
              itemBuilder: (context, index) {
                final game = savedGames[index];
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
                  trailing: const Icon(
                    Icons.bookmark,
                    color: Color(0xff800000),
                  ),
                );
              },
            ),
    );
  }
}
