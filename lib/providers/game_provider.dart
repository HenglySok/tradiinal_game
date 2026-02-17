import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameProvider extends ChangeNotifier {
  List<dynamic> _games = [];
  bool _isLoading = true;

  // History State
  final List<dynamic> _historyGames = [];
  List<dynamic> _filteredHistory = [];
  String _historySearchQuery = "";

  // Global Search State
  List<dynamic> _filteredGames = [];
  String _searchQuery = "";

  // --- GETTERS ---
  List<dynamic> get games => _games;
  bool get isLoading => _isLoading;
  List<dynamic> get historyGames => _historyGames;

  // FIX: Added the missing getter that caused your error
  List<dynamic> get filteredHistory =>
      (_historySearchQuery.isEmpty) ? _historyGames : _filteredHistory;

  List<dynamic> get filteredGames =>
      _filteredGames.isEmpty && _searchQuery.isEmpty ? _games : _filteredGames;

  // --- LOGIC ---

  Future<void> loadGames() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/games.json',
      );
      _games = json.decode(response);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading JSON: $e");
    }
  }

  void addToHistory(Map<String, dynamic> game) {
    _historyGames.removeWhere((item) => item['id'] == game['id']);
    _historyGames.insert(0, game);

    // Logic: If user is currently searching history, refresh that search too
    if (_historySearchQuery.isNotEmpty) {
      searchInHistory(_historySearchQuery);
    }

    notifyListeners();
  }

  void searchInHistory(String query) {
    _historySearchQuery = query;
    if (query.isEmpty) {
      _filteredHistory = [];
    } else {
      _filteredHistory = _historyGames.where((game) {
        final title = game['title'].toString().toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void searchGames(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredGames = [];
    } else {
      _filteredGames = _games.where((game) {
        final title = game['title'].toString().toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
