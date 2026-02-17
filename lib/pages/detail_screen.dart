import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> game;

  const DetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff800000),
        title: Text(
          game['title'],
          style: const TextStyle(color: Color(0xffFFD700)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reusing the same image path logic
            Image.asset(
              'assets/${game['imagePath'].toString().replaceFirst('assets/', '')}',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game['title'],
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff800000),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${game['views']} views",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  const Text(
                    "របៀបលេង និង ប្រវត្តិ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "នេះគឺជាខ្លឹមសារលម្អិតអំពីល្បែងប្រជាប្រិយខ្មែរមួយនេះ។ អ្នកអាចបន្ថែមព័ត៌មានបន្ថែមនៅក្នុង JSON របស់អ្នកបាន។",
                    style: TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
