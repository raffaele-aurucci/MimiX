import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/beans/user.dart';

class UserProvider extends ChangeNotifier {

  // initialize provider with null or user if exist
  UserProvider(User? user) : _user = user;

  User? _user;

  User? get user => _user;

  // Update user
  void setUser(User user) {
    _user = user;
    notifyListeners(); // notify listeners that user is updated
  }
}