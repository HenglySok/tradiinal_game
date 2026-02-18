import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/components/game_card.dart';
import 'package:tradinal_game/pages/detail_screen.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/models/game_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xff800000), // Dark Red
        elevation: 0,
        title: const Text(
          "ល្បែងប្រជាប្រិយខ្មែរ",
          style: TextStyle(
            color: Color(0xffFFD700), // Gold
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: const Color(0xffFFD700),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: gameProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/banner.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Render sections based on the game 'type' field
                  _buildSection(
                    context,
                    title: "ធ្លាប់អានញាក់សាច់",
                    games: gameProvider.games
                        .where((g) => g.type == 'popular')
                        .toList(),
                  ),
                  _buildSection(
                    context,
                    title: "ថ្មីៗ",
                    games: gameProvider.games
                        .where((g) => g.type == 'new')
                        .toList(),
                  ),
                  _buildSection(
                    context,
                    title: "ផ្សេងៗ",
                    games: gameProvider.games
                        .where(
                          (g) => g.type == 'other' || g.type == 'traditional',
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<TraditionalGame> games,
  }) {
    if (games.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff800000),
                ),
              ),
              const Text(
                "មើលទាំងអស់",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200, // Adjusted height for better card display
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];

              return GestureDetector(
                onTap: () {
                  // Add to history and Navigate to Detail
                  Provider.of<GameProvider>(
                    context,
                    listen: false,
                  ).addToHistory(game);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // IMPORTANT: Pass the whole object
                      builder: (context) => DetailScreen(game: game),
                    ),
                  );
                },
                child: GameCard(
                  // Use nameKh or title based on your model's property
                  imagePath: game.imagePath,
                  title: game.nameKh,
                  views: game.views,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
