import 'dart:convert';
import 'package:betsbi/services/feeling/feelings.dart';
import 'package:betsbi/service/HttpManager.dart';
import 'package:betsbi/service/ResponseManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/services/home/HomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    HttpManager httpManager = new HttpManager(
        path: "userProfile/moral-stats", map: <String, int>{'value': value}, context: context);
    await httpManager.post();
    ResponseManager responseManager = new ResponseManager(context: context,response: httpManager.response, onSuccess: () =>  redirectionFeelingToHomePage(context));
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
    HttpManager httpManager =
        new HttpManager(path: 'userProfile/$userId/moral-stats', context: context);
    await httpManager.get();
    ResponseManager responseManager = new ResponseManager(response: httpManager.response, context: context, elementToReturn:  getAllFeelingsFromJson(jsonToDecode: httpManager.response.body));
    return responseManager.checkResponseAndRetrieveInformation();
  }

  static List<Feelings> getAllFeelingsFromJson({@required String jsonToDecode}){
    var feelings = new List<Feelings>();
    Iterable list = json.decode(jsonToDecode);
    feelings = list.map((model) => Feelings.fromJson(model)).toList();
    feelings.forEach((element) => print(element.toString()));
    List<Feelings> allFeelings = toListFeelings(feelings);
    allFeelings.sort((a, b) => a.dayOfFeeling.compareTo(b.dayOfFeeling));
    return allFeelings;
  }
}
