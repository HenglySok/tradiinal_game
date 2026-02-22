import 'package:flutter/material.dart';
import '../models/game_model.dart';

class UserProvider extends ChangeNotifier {
  // We should also store names to keep the UI consistent
  final Map<String, String> _userDatabase = {"guest@example.com": "12345678"};
  final Map<String, String> _userNameDatabase = {
    "guest@example.com": "Guest User",
  };

  String _currentUserName = "Guest User";
  String _currentUserEmail = "guest@example.com";

  String get currentUserName => _currentUserName;
  String get currentUserEmail => _currentUserEmail;

  final List<TraditionalGame> _savedGames = [];
  final List<TraditionalGame> _likedGames = [];

  List<TraditionalGame> get savedGames => _savedGames;
  List<TraditionalGame> get likedGames => _likedGames;

  bool checkEmailExists(String email) =>
      _userDatabase.containsKey(email.trim().toLowerCase());

  bool validateLogin(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    if (_userDatabase[cleanEmail] == password) {
      _currentUserEmail = cleanEmail;
      _currentUserName = _userNameDatabase[cleanEmail] ?? "User";
      notifyListeners();
      return true;
    }
    return false;
  }

  void registerUser(String name, String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    _currentUserName = name;
    _currentUserEmail = cleanEmail;
    _userDatabase[cleanEmail] = password;
    _userNameDatabase[cleanEmail] = name; // Store the name too
    notifyListeners();
  }

  // FIXED: updatePassword method
  void updatePassword(String email, String newPassword) {
    String cleanEmail = email.trim().toLowerCase();
    if (_userDatabase.containsKey(cleanEmail)) {
      _userDatabase[cleanEmail] = newPassword; // Fixed variable name here
      notifyListeners();
    }
  }

  // Helper to get name during password reset
  String getUserNameByEmail(String email) {
    return _userNameDatabase[email.trim().toLowerCase()] ?? "User";
  }

  void toggleSave(TraditionalGame game) {
    _savedGames.any((item) => item.id == game.id)
        ? _savedGames.removeWhere((i) => i.id == game.id)
        : _savedGames.add(game);
    notifyListeners();
  }

  void toggleLike(TraditionalGame game) {
    _likedGames.any((item) => item.id == game.id)
        ? _likedGames.removeWhere((i) => i.id == game.id)
        : _likedGames.add(game);
    notifyListeners();
  }

  bool isSaved(int id) => _savedGames.any((g) => g.id == id);
  bool isLiked(int id) => _likedGames.any((g) => g.id == id);
}
