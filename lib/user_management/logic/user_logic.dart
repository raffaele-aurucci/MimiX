import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/beans/user.dart';
import 'package:mimix_app/user_management/storage/user_dao.dart';
import 'package:provider/provider.dart';

import '../beans/user_provider.dart';

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username cannot be empty';
  }
  if (value.length < 3) {
    return 'Username must be at least 3 characters long';
  }
  if (value.length > 8) {
    return 'Username must be lower than 8 characters';
  }
  return null;
}

String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return 'Age cannot be empty';
  }
  if (int.parse(value) <= 0) {
    return 'Age must be greater than 0';
  }
  if (value.length > 2) {
    return 'Age must be lower than 3 digits';
  }
  return null;
}

Future<bool?> registerUser(GlobalKey<FormState> formKey, String username,
    String age, BuildContext context) async {
  bool isValid = formKey.currentState!.validate();

  if (isValid){
    User user = User(username: username, age: int.parse(age), level: 1,
        levelCompletionDate: DateTime.now());
    UserDao userDao = UserDao();
    int userId;

    try {
      userId = await userDao.insertUser(user);
      user.id = userId;
      context.read<UserProvider>().setUser(user);
      return true;
    } catch (e) {
      return false;
    }

  }

  return null;
}