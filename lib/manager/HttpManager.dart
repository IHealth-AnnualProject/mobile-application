import 'dart:async';
import 'dart:convert';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'SettingsManager.dart';

class HttpManager {
  String path;
  final Map<String, dynamic> map;
  http.Response response;
  final BuildContext context;

  HttpManager({@required this.path, this.map, @required this.context});

  get() async {
    try {
      response = await http.get(
        SettingsManager.cfg.getString("apiUrl") + this.path,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' +
              SettingsManager.applicationProperties.getCurrentToken(),
        },
      ).timeout(Duration(seconds: 6));
    } on TimeoutException catch (_) {
      FlushBarMessage.informationMessage(
              content: SettingsManager.mapLanguage["TimeOut"])
          .showFlushBarAndDo(
              context, () => SettingsController.disconnect(context));
    }
  }

  patch() async {
    try {
      response = await http
          .patch(
            SettingsManager.cfg.getString("apiUrl") + this.path,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' +
                  SettingsManager.applicationProperties.getCurrentToken(),
            },
            body: jsonEncode(this.map),
          )
          .timeout(Duration(seconds: 6));
    } on TimeoutException catch (_) {
      FlushBarMessage.informationMessage(
              content: SettingsManager.mapLanguage["TimeOut"])
          .showFlushBarAndDo(
              context, () => SettingsController.disconnect(context));
    }
  }

  post() async {
    try {
      response = await http
          .post(
            SettingsManager.cfg.getString("apiUrl") + this.path,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ' +
                  SettingsManager.applicationProperties.getCurrentToken(),
            },
            body: jsonEncode(this.map),
          )
          .timeout(Duration(seconds: 6));
    } on TimeoutException catch (_) {
      FlushBarMessage.informationMessage(
              content: SettingsManager.mapLanguage["TimeOut"])
          .showFlushBarAndDo(
              context, () => SettingsController.disconnect(context));
    }
  }

  postWithoutBody() async {
    try {
      response = await http.post(
        SettingsManager.cfg.getString("apiUrl") + this.path,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' +
              SettingsManager.applicationProperties.getCurrentToken(),
        },
      ).timeout(Duration(seconds: 6));
    } on TimeoutException catch (_) {
      FlushBarMessage.informationMessage(
              content: SettingsManager.mapLanguage["TimeOut"])
          .showFlushBarAndDo(
              context, () => SettingsController.disconnect(context));
    }
  }
  delete() async {
    try {
      response = await http.delete(
        SettingsManager.cfg.getString("apiUrl") + this.path,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' +
              SettingsManager.applicationProperties.getCurrentToken(),
        },
      ).timeout(Duration(seconds: 6));
    } on TimeoutException catch (_) {
      FlushBarMessage.informationMessage(
              content: SettingsManager.mapLanguage["TimeOut"])
          .showFlushBarAndDo(
              context, () => SettingsController.disconnect(context));
    }
  }

  postWithoutAccessToken() async {
    try {
      response = await http
          .post(
            SettingsManager.cfg.getString("apiUrl") + this.path,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(this.map),
          )
          .timeout(Duration(seconds: 6));
    } on TimeoutException catch (_) {
      FlushBarMessage.informationMessage(
              content: SettingsManager.mapLanguage["TimeOut"])
          .showFlushBarAndDo(
              context, () => SettingsController.disconnect(context));
    }
  }

  setPath({@required String newPath}) {
    this.path = newPath;
  }
}
