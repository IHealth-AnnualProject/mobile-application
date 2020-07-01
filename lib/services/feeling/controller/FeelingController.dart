import 'dart:convert';
import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/feeling/model/feelings.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/home/view/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeelingController {
  static Future<void> redirectionFeelingToHomePage(BuildContext context) async {
    await SettingsManager.storage.write(
      key: "feelingsDate",
      value: DateTime.now().toString(),
    ).whenComplete(() async =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false));
  }

  static Future<void> sendFeelings(int value, BuildContext context) async {
    HttpManager httpManager = new HttpManager(
        path: "userProfile/moral-stats",
        map: <String, int>{'value': value},
        context: context);
    await httpManager.post();
    ResponseManager responseManager = new ResponseManager(
        context: context,
        response: httpManager.response,
        onSuccess: () async => await redirectionFeelingToHomePage(context));
    responseManager.checkResponseAndExecuteFunctionIfOk();
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
    Map<String, Feelings> mapFeelings = new Map<String, Feelings>();
    feelings.forEach((element) => mapFeelings.putIfAbsent(
        element.dayOfFeeling.day.toString() +
            "-" +
            element.dayOfFeeling.month.toString(),
        () => element));
    feelings = new List<Feelings>();
    mapFeelings.forEach((key, value) => feelings.add(value));
    return feelings;
  }

  static Future<List<Feelings>> getAllFeelings(
      String userId, BuildContext context) async {
    HttpManager httpManager = new HttpManager(
        path: 'userProfile/$userId/moral-stats', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(
        response: httpManager.response,
        context: context,);
    return responseManager.checkResponseAndReturnTheDesiredElement(elementToReturn: getAllFeelingsFromJson(jsonToDecode: httpManager.response.body));
  }

  static List<Feelings> getAllFeelingsFromJson(
      {@required String jsonToDecode}) {
    var feelings = new List<Feelings>();
    Iterable list = json.decode(jsonToDecode);
    feelings = list.map((model) => Feelings.fromJson(model)).toList();
    List<Feelings> allFeelings = toListFeelings(feelings);
    allFeelings.sort((a, b) => a.dayOfFeeling.compareTo(b.dayOfFeeling));
    return allFeelings;
  }
}
