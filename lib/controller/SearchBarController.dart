import 'dart:convert';

import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class SearchBarController {
  static Future<List<User>> getAllProfile() async {
    var users = new List<User>();
    final http.Response responseProfileUSer = await http.get(
      SettingsManager.cfg.getString("apiUrl") + 'userProfile',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
    );
    Iterable list = json.decode(responseProfileUSer.body);
    users.addAll(list.map((model) => UserProfile.fromJson(model)).toList());

    // remove psy from list if you're already a psy
    if (responseProfileUSer.statusCode == 200) {
      final http.Response responseProfilePsy = await http.get(
        SettingsManager.cfg.getString("apiUrl") + 'psychologist',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + SettingsManager.currentToken,
        },
      );
      list = json.decode(responseProfilePsy.body);

      users.addAll(
          list.map((model) => Psychologist.fromJsonForSearch(model)).toList());
      users.removeWhere((user) => user.profileId == SettingsManager.currentId);
      users.forEach((e) => print(e.profileId));
      if (responseProfileUSer.statusCode == 200) {
        return users;
      } else
        return null;
    } else
      return null;
  }
}
