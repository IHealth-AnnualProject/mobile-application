import 'dart:collection';
import 'dart:convert';
import 'package:betsbi/model/response.dart';
import 'package:betsbi/model/feelings.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/HomeView.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FeelingController {
  static void redirectionFeelingToHomePage(BuildContext context) {
    SettingsManager.storage
        .write(key: "feelingsDate", value: DateTime.now().toString())
        .then((r) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false));
  }

  static Future<void> sendFeelings(int value, BuildContext context) async {
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
    checkResponseAndRedirectifOk(response, context);
  }

  static void checkResponseAndRedirectifOk(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      redirectionFeelingToHomePage(context);
    } else
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
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

  static Future<List<Feelings>> getAllFeelings(
      String userId, BuildContext context) async {
    final http.Response response = await http.get(
      SettingsManager.cfg.getString("apiUrl") +
          'userProfile/' +
          userId +
          '/moral-stats',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + SettingsManager.currentToken,
      },
    );
    return checkResponseAndReturnListFeelingsIfOk(response, context);
  }

  static List<Feelings> checkResponseAndReturnListFeelingsIfOk(
      http.Response response, BuildContext context) {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      var feelings = new List<Feelings>();
      Iterable list = json.decode(response.body);
      feelings = list.map((model) => Feelings.fromJson(model)).toList();
      List<Feelings> allFeelings = toListFeelings(feelings);
      allFeelings.sort((a, b) => a.dayOfFeeling.compareTo(b.dayOfFeeling));
      return allFeelings;
    } else {
      FlushBarMessage.errorMessage(
          content: Response
              .fromJson(json.decode(response.body))
              .content)
          .showFlushBar(context);
      return null;
    }
  }

  static LinkedHashMap<String, int> renderMapFeeling(List<Feelings> feelings) {
    LinkedHashMap<String, int> mapFeeling = new LinkedHashMap<String, int>();
    feelings.forEach((feeling) => mapFeeling.putIfAbsent(
        DateFormat('EEEE').format(feeling.dayOfFeeling),
        () => feeling.feelingsPoint));
    return mapFeeling;
  }
}
