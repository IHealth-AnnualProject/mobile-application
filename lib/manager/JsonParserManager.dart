import 'dart:convert';

import 'package:flutter/services.dart';

class JsonParserManager {
  static Future<Map<String, dynamic>> parseJsonFromAssetsToMap(
      String assetsPath) async {
    return await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static Map<String, dynamic> parseJsonFromResponseToMap(
      String response)  {
    return jsonDecode(response);
  }
}