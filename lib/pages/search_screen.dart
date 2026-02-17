import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/pages/detail_screen.dart';

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
          // The Search Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) =>
                  gameProvider.searchGames(value), // Real-time logic
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

          // The Results List
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

  Widget _searchResultCard(BuildContext context, dynamic game) {
    return ListTile(
      onTap: () {
        // Logically save to history when clicked
        Provider.of<GameProvider>(context, listen: false).addToHistory(game);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(game: game)),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/${game['imagePath'].toString().replaceFirst('assets/', '')}',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        game['title'],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${game['views']} views"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
