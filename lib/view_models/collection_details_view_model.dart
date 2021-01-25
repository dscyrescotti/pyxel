import 'package:flutter/material.dart';
import 'package:pyxel/models/collection.dart';
import 'package:pyxel/models/photo.dart';
import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class CollectionDetailsViewModel extends ChangeNotifier {

  final String id;
  CollectionDetailsViewModel({this.id});

  Collection collection;
  List<Photo> photos = [];

  bool isEmpty = false;
  int photoPage = 1;
  bool photoEnd = false;

  Future<void> fetchCollection() async {
    try {
      await APIService.fetch(
        'collections/$id', 
        headers: {
          'Authorization':'Client-ID ${DotEnv().env['API_KEY']}'
        },
        callback: (json) {
          final Map<String, dynamic> data = jsonDecode(json);
          collection = Collection.fromJson(data);
        },
      );
      print(collection.tags);
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
        'collections/$id/photos', 
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
          final _photos = Photo.fromJsonArray(list);
          if (isRefresh) {
            photoEnd = _photos.isEmpty || _photos.length < 30;
            photos = _photos;
          } else {
            photoEnd = _photos.isEmpty || _photos.length < 30;
            photos.addAll(_photos);
          }
          photoPage++;
        },
      );
      if (photos.isEmpty) {
        isEmpty = true;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}