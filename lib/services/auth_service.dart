import 'package:flutter/material.dart';
import 'db_service.dart';

class AuthService with ChangeNotifier {
  int? _userId;

  int? get userId => _userId;

  Future<bool> login(String username, String password) async {
    final user = await DBService.instance.getUser(username, password);
    if (user != null) {
      _userId = user['id'];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password) async {
    final userId = await DBService.instance.insertUser(username, password);
    if (userId != 0) {
      _userId = userId;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _userId = null;
    notifyListeners();
  }
}
