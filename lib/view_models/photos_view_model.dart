import 'package:flutter/material.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class PhotosViewModel extends ChangeNotifier {
  List<Photo> photos = List<Photo>();
  int currentPage = 1;
  Future<void> fetchPhotos({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    }
    try {
      await APIService.fetch(
        'photos', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        params: {
          'page': '$currentPage',
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
          currentPage++;
        },
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}