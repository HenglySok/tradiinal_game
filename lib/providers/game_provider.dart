import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  List<TraditionalGame> _games = [];
  bool _isLoading = true;

  final List<TraditionalGame> _historyGames = [];
  List<TraditionalGame> _filteredHistory = [];
  String _historySearchQuery = "";

  List<TraditionalGame> _filteredGames = [];
  String _searchQuery = "";

  // --- GETTERS ---
  List<TraditionalGame> get games => _games;
  bool get isLoading => _isLoading;
  List<TraditionalGame> get historyGames => _historyGames;

  List<TraditionalGame> get filteredHistory =>
      (_historySearchQuery.isEmpty) ? _historyGames : _filteredHistory;

  List<TraditionalGame> get filteredGames =>
      (_searchQuery.isEmpty) ? _games : _filteredGames;

  // --- LOADING ---
  Future<void> loadGames() async {
    try {
      final String listResponse = await rootBundle.loadString(
        'assets/data/games.json',
      );
      final String detailResponse = await rootBundle.loadString(
        'assets/data/details.json',
      );

      final List<dynamic> listData = json.decode(listResponse);
      final List<dynamic> detailData = json.decode(detailResponse);

      _games = listData.map((listItem) {
        final detailItem = detailData.firstWhere(
          (d) => d['id'] == listItem['id'],
          orElse: () => null,
        );
        return TraditionalGame.fromMergedJson(listItem, detailItem);
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Error: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- ACTIONS ---
  void addToHistory(TraditionalGame game) {
    _historyGames.removeWhere((item) => item.id == game.id);
    _historyGames.insert(0, game);
    if (_historySearchQuery.isNotEmpty) searchInHistory(_historySearchQuery);
    notifyListeners();
  }

  void searchInHistory(String query) {
    _historySearchQuery = query;
    if (query.isEmpty) {
      _filteredHistory = [];
    } else {
      _filteredHistory = _historyGames.where((game) {
        // Search by Khmer name or English name
        return game.nameKh.contains(query) ||
            game.nameEn.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void searchGames(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredGames = _games;
    } else {
      _filteredGames = _games.where((game) {
        return game.nameKh.contains(query) ||
            game.nameEn.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
