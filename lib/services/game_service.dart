import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/game_model.dart';

class GameService {
  Future<List<TraditionalGame>> loadAllGames() async {
    try {
      // 1. Load BOTH JSON files from assets
      final String listRes = await rootBundle.loadString(
        'assets/data/games.json',
      );
      final String detailRes = await rootBundle.loadString(
        'assets/data/details.json',
      );

      // 2. Decode the strings into raw Lists
      final List<dynamic> listData = json.decode(listRes);
      final List<dynamic> detailData = json.decode(detailRes);

      List<TraditionalGame> mergedGames = [];

      // 3. Logic: Synchronize the data by matching IDs
      for (var listItem in listData) {
        final detailItem = detailData.firstWhere(
          (d) => d['id'] == listItem['id'],
          orElse: () => null,
        );

        if (detailItem != null) {
          // FIX: Convert the '_JsonMap' into a 'TraditionalGame' object
          // This prevents the TypeError seen in your error screen
          mergedGames.add(TraditionalGame.fromMergedJson(listItem, detailItem));
        }
      }

      return mergedGames;
    } catch (e) {
      print("Error loading games: $e");
      return [];
    }
  }
}
