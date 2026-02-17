import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/main_wrapper.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/providers/user_provider.dart'; // Add this import

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Load games immediately on startup
        ChangeNotifierProvider(
          create: (context) => GameProvider()..loadGames(),
        ),
        // Add UserProvider here so it can be used in Signup/Login
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Start at MainWrapper or LoginScreen depending on your flow
      home: MainWrapper(),
    );
  }
}
