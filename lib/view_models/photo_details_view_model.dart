import 'package:flutter/material.dart';
import 'package:pyxel/models/photo.dart';
import '../services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class PhotoDetailsViewModel extends ChangeNotifier {
  final String id;
  PhotoDetailsViewModel({this.id});

  Photo photo;

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
    } catch (error) {
      print(error);
    }
  }
}