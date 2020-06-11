import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'SettingsManager.dart';

class HttpManager {
  String path;
  final Map<String, dynamic> map;
  http.Response response;

  HttpManager({this.path, this.map});

  get() async {
    response = await http.get(
      SettingsManager.cfg.getString("apiUrl") + this.path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
    );
  }

  patch() async {
    response = await http.patch(
      SettingsManager.cfg.getString("apiUrl") + this.path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
      },
      body: jsonEncode(this.map),
    );
  }

  post() async {
      response = await http.post(
        SettingsManager.cfg.getString("apiUrl") + this.path,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
          'Bearer ' + SettingsManager.applicationProperties.getCurrentToken(),
        },
        body: jsonEncode(this.map),
      );
  }

  postWithoutAccessToken() async {
    response = await http.post(
      SettingsManager.cfg.getString("apiUrl") + this.path,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(this.map),
    );
  }

  setPath({@required String newPath}) {
    this.path = newPath;
  }
}
