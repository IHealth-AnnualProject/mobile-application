import 'dart:collection';

import 'package:betsbi/controller/FeelingController.dart';

class Feelings {
  DateTime dayOfFeeling;
  int feelingsPoint;
  List<String> moralDays;
  List<int> moralStats;

  Feelings(this.dayOfFeeling, this.feelingsPoint);

  Feelings.normalConstructor({this.dayOfFeeling, this.feelingsPoint})
    : moralDays = new List<String>(),
      moralStats = new List<int>();



  Feelings.defaultConstructor({DateTime dayOfFeeling , String feelingsPoint  })
  : dayOfFeeling = dayOfFeeling ?? DateTime.now(),
    feelingsPoint = feelingsPoint ?? 0;

  factory Feelings.fromJson(Map<String, dynamic> json) {
    return Feelings.normalConstructor(
        dayOfFeeling: DateTime.parse(json['created']), feelingsPoint: json['value']);
  }

  Future<bool> getUserFeelings(String userID) async {
    LinkedHashMap<String, int> mapFeeling = new LinkedHashMap<String, int>();
    List<Feelings> feelings = await FeelingController.getAllFeelings(userID);
    mapFeeling = FeelingController.renderMapFeeling(feelings);
    mapFeeling.forEach((key, value) {
      this.moralStats.add(value);
      this.moralDays.add("'"+key+"'");
    });
    return true;
  }
}
