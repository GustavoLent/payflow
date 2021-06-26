import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel _user;

  UserModel get user => _user;

  void setUser(BuildContext context, UserModel user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    final userAsJson = user.toJson();
    await instance.setString("user", userAsJson);
    return;
  }

  Future<void> loadExistentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    final hasUserDefined = instance.containsKey("user");

    if (hasUserDefined) {
      final userAsJson = instance.getString("user");

      final parsedUser = UserModel.fromJson(userAsJson);
      return this.setUser(context, parsedUser);
    } else {
      return setUser(context, null);
    }
  }
}
