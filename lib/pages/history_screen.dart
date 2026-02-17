import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/pages/detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We watch the provider for any changes in search results
    final gameProvider = Provider.of<GameProvider>(context);
    final history = gameProvider.filteredHistory;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "ប្រវត្តិនៃការអាន",
          style: TextStyle(
            color: Color(0xff800000),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar Logic
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) =>
                  gameProvider.searchInHistory(value), // Real-time search
              decoration: InputDecoration(
                hintText: "ស្វែងរកល្បែងប្រជាប្រិយក្នុងប្រវត្តិ",
                prefixIcon: const Icon(Icons.search, color: Color(0xff800000)),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: history.isEmpty
                ? const Center(child: Text("មិនឃើញមានក្នុងប្រវត្តិទេ"))
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final game = history[index];
                      return _buildHistoryCard(context, game);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, dynamic game) {
    return GestureDetector(
      onTap: () {
        // Logic: Navigate to details when clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(game: game)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/${game['imagePath'].toString().replaceFirst('assets/', '')}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${game['views']} views",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
