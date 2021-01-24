import 'package:flutter/material.dart';
import 'package:pyxel/models/photo.dart';
import 'package:pyxel/models/result.dart';
import 'package:pyxel/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class SearchPhotosViewModel extends ChangeNotifier {
  List<Photo> photos = List<Photo>();
  int currentPage = 1;
  String _query = '';
  bool isInit = false;

  Future<void> initLoad(String query) async {
    if (query.isEmpty) {
      isInit = false;
      notifyListeners();
      return;
    }
    _query = query;
    isInit = true;
    this.photos.clear();
    notifyListeners();
    await searchPhotos();
  }

  Future<void> searchPhotos({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    }
    try {
      await APIService.fetch(
        'search/photos', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        params: {
          'query': _query,
          'page': '$currentPage',
          'per_page': '30',
          'order_by': 'latest',
        },
        callback: (json) {
          final Map<String, dynamic> result = jsonDecode(json);
          final decoded = PhotoResult.fromJson(result);
          if (isRefresh) {
            photos = decoded.results;
          } else {
            photos.addAll(decoded.results);
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

