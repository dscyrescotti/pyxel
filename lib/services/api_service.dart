import 'package:http/http.dart';

class APIService {
  static const String BASE_URL = "api.unsplash.com";
  
  static Future<void> fetch(String endpoint, {Map<String, String> params, Map<String, String> headers, void Function(String) callback}) async {
    final uri = Uri.https(BASE_URL, endpoint, params ?? {});
    final response = await get(uri, headers: headers ?? {});
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw "[Error]: API response ends with status code ${response.statusCode}.";
    }
    callback(response.body);
  }
}