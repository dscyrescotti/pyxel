import 'package:flutter/material.dart';
import 'package:pyxel/models/user.dart';
// import 'package:pyxel/models/user.dart';
import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class UserProfileViewModel extends ChangeNotifier {
  final String username;
  UserProfileViewModel({this.username});

  User user;

  Future<void> fetchUser() async {
    try {
      await APIService.fetch(
        'users/$username', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        callback: (json) {
          final Map<String, dynamic> data = jsonDecode(json);
          user = User.fromJson(data);
        },
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}