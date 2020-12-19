import 'package:flutter/material.dart';
import 'package:pyxel/models/collection.dart';
import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class CollectionsViewModel extends ChangeNotifier {
  List<Collection> collections = List<Collection>();
  int currentPage = 1;
  Future<void> fetchCollections({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    }
    try {
      await APIService.fetch(
        'collections', 
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
            collections = Collection.fromJsonArray(list);
          } else {
            collections.addAll(Collection.fromJsonArray(list));
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