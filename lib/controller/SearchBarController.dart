import 'dart:convert';

import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:http/http.dart' as http;

class SearchBarController{
  static Future<List<UserProfile>> getAllUserProfile() async {
        final http.Response response = await http.get(
          SettingsManager.cfg.getString("apiUrl") + 'userProfile',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + SettingsManager.currentToken,
          },
        );
        var users = new List<UserProfile>();
        Iterable list = json.decode(response.body);
        users = list.map((model) => UserProfile.fromJson(model)).toList();
        users.removeWhere((user) => user.userProfileId == SettingsManager.currentId);
        // remove psy from list if you're already a psy
        if (response.statusCode == 200) {
          return users;
        } else
          return null;
  }
}