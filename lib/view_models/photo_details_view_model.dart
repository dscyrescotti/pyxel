import 'package:flutter/material.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/models/user.dart';
import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class PhotoDetailsViewModel extends ChangeNotifier {
  final String id;
  PhotoDetailsViewModel({this.id});

  Photo photo;
  User user;

  Future<void> fetchPhoto() async {
    try {
      await APIService.fetch(
        'photos/$id', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        callback: (json) {
          final Map<String, dynamic> data = jsonDecode(json);
          photo = Photo.fromJson(data);
        },
      );
      notifyListeners();
      await APIService.fetch(
        'users/${photo.user.username}',
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        callback: (json) {
          final Map<String, dynamic> data = jsonDecode(json);
          user = User.fromJson(data);
        }
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}