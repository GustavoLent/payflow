import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  Future<void> gogleSignIn(BuildContext context) async {
    final authController = AuthController();
    final _googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(response.displayName, response.photoUrl);

      authController.setUser(context, user);
    } catch (error) {
      authController.setUser(context, null);
      print(error);
    }
  }
}