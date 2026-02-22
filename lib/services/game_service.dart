import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/game_model.dart';

class GameService {
  Future<List<TraditionalGame>> loadAllGames() async {
    try {
      
      final String listRes = await rootBundle.loadString(
        'assets/data/games.json',
      );
      final String detailRes = await rootBundle.loadString(
        'assets/data/details.json',
      );

      
      final List<dynamic> listData = json.decode(listRes);
      final List<dynamic> detailData = json.decode(detailRes);

      List<TraditionalGame> mergedGames = [];

      
      for (var listItem in listData) {
        final detailItem = detailData.firstWhere(
          (d) => d['id'] == listItem['id'],
          orElse: () => null,
        );

        if (detailItem != null) {
          
          
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
