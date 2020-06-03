import 'package:betsbi/controller/FeelingController.dart';
import 'package:flutter/cupertino.dart';

class Feelings {
  DateTime dayOfFeeling;
  int feelingsPoint;

  Feelings(this.dayOfFeeling, this.feelingsPoint);

  Feelings.normalConstructor({this.dayOfFeeling, this.feelingsPoint});



  Feelings.defaultConstructor({DateTime dayOfFeeling , String feelingsPoint  })
  : dayOfFeeling = dayOfFeeling ?? DateTime.now(),
    feelingsPoint = feelingsPoint ?? 0;

  factory Feelings.fromJson(Map<String, dynamic> json) {
    return Feelings.normalConstructor(
        dayOfFeeling: DateTime.parse(json['created']), feelingsPoint: json['value']);
  }

  Future<List<Feelings>> getUserFeelings(String userID, BuildContext context) async {
    return  await FeelingController.getAllFeelings(userID, context);
  }
}
