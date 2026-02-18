import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/pages/detail_screen.dart';
import 'package:tradinal_game/models/game_model.dart'; // Import the model

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final results = gameProvider.filteredGames;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "ស្វែងរកល្បែង",
          style: TextStyle(
            color: Color(0xff800000),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // 1. Search Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => gameProvider.searchGames(value),
              decoration: InputDecoration(
                hintText: "វាយឈ្មោះល្បែងនៅទីនេះ...",
                prefixIcon: const Icon(Icons.search, color: Color(0xff800000)),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Results List
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text("មិនឃើញមានល្បែងដែលអ្នកស្វែងរកទេ"))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final game = results[index];
                      return _searchResultCard(context, game);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Changed 'dynamic game' to 'TraditionalGame game'
  Widget _searchResultCard(BuildContext context, TraditionalGame game) {
    return ListTile(
      onTap: () {
        // Add to history and navigate
        Provider.of<GameProvider>(context, listen: false).addToHistory(game);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(game: game)),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          game.imagePath, // Fixed: Direct access
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
        ),
      ),
      title: Text(
        game.nameKh, // Fixed: Use nameKh or title based on your model
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${game.views} views"), // Fixed: Use dot notation
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
