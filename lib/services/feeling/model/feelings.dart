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

  @override
  String toString() {
    return "Day : " + dayOfFeeling.toIso8601String() + " moral-stats : " + feelingsPoint.toString();
  }
}
