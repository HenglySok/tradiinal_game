import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // Logic: Store Email as the KEY and Password as the VALUE
  final Map<String, String> _userDatabase = {
    "guest@example.com": "12345678", // Default password for guest
    "test@gmail.com": "password123",
  };

  String _currentUserName = "Guest User";
  String _currentUserEmail = "guest@example.com";

  String get currentUserName => _currentUserName;
  String get currentUserEmail => _currentUserEmail;

  // Logic: Check if email exists in our Map
  bool checkEmailExists(String email) {
    return _userDatabase.containsKey(email.trim().toLowerCase());
  }

  // Logic: Verify if email and password match
  bool validateLogin(String email, String password) {
    String cleanEmail = email.trim().toLowerCase();
    if (_userDatabase.containsKey(cleanEmail) &&
        _userDatabase[cleanEmail] == password) {
      _currentUserEmail = cleanEmail;
      // For now, we keep the name as "User" or search from a name map
      notifyListeners();
      return true;
    }
    return false;
  }

  // Updated Sign Up: Save email and password together
  void registerUser(String name, String email, String password) {
    _currentUserName = name;
    _currentUserEmail = email.trim().toLowerCase();
    _userDatabase[_currentUserEmail] = password; // Save password to map
    notifyListeners();
  }
}
