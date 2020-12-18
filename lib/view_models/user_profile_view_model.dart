import 'package:flutter/material.dart';
import 'package:pyxel/models/user.dart';
import 'package:pyxel/models/photo.dart';
import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class UserProfileViewModel extends ChangeNotifier {
  final String username;
  UserProfileViewModel({this.username});

  User user;
  List<Photo> photos = List<Photo>();
  List<Photo> likes = List<Photo>();
  int photoPage = 1;
  int likePage = 1;

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

  Future<void> fetchPhotos({bool isRefresh = false}) async {
    if (isRefresh) {
      photoPage = 1;
    }
    try {
      await APIService.fetch(
        'users/$username/photos', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        params: {
          'page': '$photoPage',
          'per_page': '30',
          'order_by': 'latest',
        },
        callback: (json) {
          final Iterable<dynamic> list = jsonDecode(json);
          if (isRefresh) {
            photos = Photo.fromJsonArray(list);
          } else {
            photos.addAll(Photo.fromJsonArray(list));
          }
          photoPage++;
        },
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchLikes({bool isRefresh = false}) async {
    if (isRefresh) {
      likePage = 1;
    }
    try {
      await APIService.fetch(
        'users/$username/likes', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        params: {
          'page': '$likePage',
          'per_page': '30',
          'order_by': 'latest',
        },
        callback: (json) {
          final Iterable<dynamic> list = jsonDecode(json);
          if (isRefresh) {
            likes = Photo.fromJsonArray(list);
          } else {
            likes.addAll(Photo.fromJsonArray(list));
          }
          likePage++;
        },
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}