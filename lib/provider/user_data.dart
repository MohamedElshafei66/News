import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  String _username = '';
  String _email = '';

  String get username => _username;
  String get email => _email;

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';
    _email = prefs.getString('email') ?? '';
    notifyListeners(); // Notify listeners about the change
  }
  // Set user data and save to SharedPreferences
  void setMyData(String username, String email) async {
    _username = username;
    _email = email;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    notifyListeners();
  }

  // Clear user data from SharedPreferences
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    _username = '';
    _email = '';
    notifyListeners();
  }
}