import 'package:flutter/material.dart';
import 'package:tradinal_game/models/game_model.dart';

class UserProvider extends ChangeNotifier {
  final Map<String, String> _userDatabase = {
    "guest@example.com": "12345678",
    "test@gmail.com": "password123",
  };

  String _currentUserName = "Guest User";
  String _currentUserEmail = "guest@example.com";

  String get currentUserName => _currentUserName;
  String get currentUserEmail => _currentUserEmail;

  final List<TraditionalGame> _savedGames = [];
  final List<TraditionalGame> _likedGames = [];

  // --- ADDED GETTERS ---
  // These allow your Profile and List screens to access the data
  List<TraditionalGame> get savedGames => _savedGames;
  List<TraditionalGame> get likedGames => _likedGames;

  // --- LOGIN LOGIC ---
  bool checkEmailExists(String email) {
    return _userDatabase.containsKey(email.trim().toLowerCase());
  }

  bool validateLogin(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    if (_userDatabase.containsKey(cleanEmail) &&
        _userDatabase[cleanEmail] == password) {
      _currentUserEmail = cleanEmail;
      notifyListeners();
      return true;
    }
    return false;
  }

  void registerUser(String name, String email, String password) {
    _currentUserName = name;
    _currentUserEmail = email.trim().toLowerCase();
    _userDatabase[_currentUserEmail] = password;
    notifyListeners();
  }

  // --- COLLECTION LOGIC ---
  void toggleSave(TraditionalGame game) {
    if (_savedGames.any((item) => item.id == game.id)) {
      _savedGames.removeWhere((item) => item.id == game.id);
    } else {
      _savedGames.add(game);
    }
    notifyListeners();
  }

  void toggleLike(TraditionalGame game) {
    if (_likedGames.any((item) => item.id == game.id)) {
      _likedGames.removeWhere((item) => item.id == game.id);
    } else {
      _likedGames.add(game);
    }
    notifyListeners();
  }

  bool isSaved(int id) => _savedGames.any((game) => game.id == id);
  bool isLiked(int id) => _likedGames.any((game) => game.id == id);
}
