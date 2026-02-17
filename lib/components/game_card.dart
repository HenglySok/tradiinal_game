import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String views;

  const GameCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 120,
      height: 170,
      child: Card(
        shadowColor: Colors.grey,
        child: Column(
          children: [
            // Image
            // Change this part in your build method:

            // Image
            // Inside your build method
            Image.asset(
              // If your JSON says "assets/images/..."
              // and Flutter Web is adding "assets/" automatically,
              // we remove the first "assets/" from the string.
              imagePath.replaceFirst('assets/', ''),
              width: 94,
              height: 100,
              fit: BoxFit.cover,
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Views
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(views, style: const TextStyle(fontSize: 12)),
                  const Text("views", style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
