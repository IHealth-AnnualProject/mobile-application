import 'dart:collection';
import 'dart:convert';
import 'package:betsbi/model/feelings.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FeelingController {
  static void redirectionFeelingToHomePage(BuildContext context) {
    SettingsManager.storage
        .write(key: "feelingsDate", value: DateTime.now().toString())
        .then((r) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  static Future<bool> sendFeelings(int value) async {
    final http.Response response = await http.post(
      SettingsManager.cfg.getString("apiUrl") + 'userProfile/moral-stats',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
      body: jsonEncode(<String, int>{
        'value': value,
      }),
    );
    if (response.statusCode == 201) {
      return true;
    } else
      return false;
  }

  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  static List<Feelings> toListFeelings(List<Feelings> listEntry) {
    List<Feelings> feelings = new List<Feelings>();
    DateTime currentDate = DateTime.now();
    listEntry.forEach((feeling) {
      if (weekNumber(feeling.dayOfFeeling) == weekNumber(currentDate))
        feelings.add(feeling);
    });
    return feelings;
  }

  static Future<List<Feelings>> getAllFeelings() async {
    final http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") +
          'userProfile/' +
          SettingsManager.currentProfileId +
          '/moral-stats',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
    );
    var feelings = new List<Feelings>();
    Iterable list = json.decode(response.body);
    feelings = list.map((model) => Feelings.fromJson(model)).toList();
    List<Feelings> allFeelings = toListFeelings(feelings);
    allFeelings.sort((a, b) => a.dayOfFeeling.compareTo(b.dayOfFeeling));
    if (response.statusCode == 200) {
      return allFeelings;
    } else
      return null;
  }

  static HashMap<String, int> renderMapFeeling(List<Feelings> feelings){
    HashMap<String, int> mapFeeling = new HashMap<String, int>();
    feelings.forEach((feeling) => mapFeeling.putIfAbsent(
        DateFormat('EEEE').format(feeling.dayOfFeeling), () => feeling.feelingsPoint));
    return mapFeeling;
  }

}
