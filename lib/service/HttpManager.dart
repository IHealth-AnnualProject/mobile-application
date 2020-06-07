import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'SettingsManager.dart';

class HttpManager {
  final String path;
  final Map<String, dynamic> map;

  HttpManager({this.path, this.map});

  get() async {
    final http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") + this.path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
    );
  }






  update() async {
    final http.Response response = await http.patch(
      SettingsManager.cfg.getString("apiUrl") + this.path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
      body: jsonEncode(map),
    );
  }
}
