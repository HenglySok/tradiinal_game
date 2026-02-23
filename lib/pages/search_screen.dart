import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/Colors/app_colors.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/pages/detail_screen.dart';
import 'package:tradinal_game/models/game_model.dart'; 

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
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => gameProvider.searchGames(value),
              decoration: InputDecoration(
                hintText: "វាយឈ្មោះល្បែងនៅទីនេះ...",
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          
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

  
  Widget _searchResultCard(BuildContext context, TraditionalGame game) {
    return ListTile(
      onTap: () {
        
        Provider.of<GameProvider>(context, listen: false).addToHistory(game);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(game: game)),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          game.imagePath, 
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
        ),
      ),
      title: Text(
        game.nameKh, 
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${game.views} views"), 
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
