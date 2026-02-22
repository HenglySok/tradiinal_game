import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/main_wrapper.dart';
import 'package:tradinal_game/providers/game_provider.dart';
import 'package:tradinal_game/providers/user_provider.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        
        ChangeNotifierProvider(
          create: (context) => GameProvider()..loadGames(),
        ),
        
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
      
      home: MainWrapper(),
    );
  }
}
