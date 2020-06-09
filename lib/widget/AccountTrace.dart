import 'package:async/async.dart';
import 'package:betsbi/model/feelings.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/DefaultCircleAvatar.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AccountTrace extends StatefulWidget {
  final User profile;

  AccountTrace({Key key, @required this.profile}) : super(key: key);

  State<AccountTrace> createState() => _AccountTraceState();
}

class _AccountTraceState extends State<AccountTrace> {
  List<Feelings> feelings;
  AsyncMemoizer _memorizer = AsyncMemoizer();

   List<charts.Series<Feelings, DateTime>> _createSampleData() {
    return [
      new charts.Series<Feelings, DateTime>(
        id: 'Feelings',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Feelings feelings, _) => feelings.dayOfFeeling,
        measureFn: (Feelings feelings, _) => feelings.feelingsPoint,
        data: feelings,
      )
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  _fetchData() {
    return this._memorizer.runOnce(() async {
      Feelings feeling = new Feelings.normalConstructor();
      feelings = await feeling.getUserFeelings(this.widget.profile.profileId, context);
      return feelings;
    });
  }

  @override
  void dispose() {
    this._memorizer = AsyncMemoizer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 45,
        ),
        DefaultCircleAvatar(
          imagePath: "assets/user.png",
        ),
        SizedBox(
          height: 45,
        ),
        DefaultTextTitle(
          title: this.widget.profile.username + " lv.1",
        ),
        SizedBox(
          height: 45,
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              SettingsManager.mapLanguage["PersonalTrace"],
              style: TextStyle(
                  fontSize: 30, color: Color.fromRGBO(0, 157, 153, 1)),
            )),
        Divider(
          color: Color.fromRGBO(0, 157, 153, 1),
          thickness: 2,
        ),
        SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return WaitingWidget();
            } else {
              // data loaded:
              return Card(
                elevation: 10,
                child: Container(
                  child: new charts.TimeSeriesChart(
                    _createSampleData(),
                    animate: false,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                    domainAxis: charts.DateTimeAxisSpec(
                      tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                        day: charts.TimeFormatterSpec(
                          format: 'dd',
                          transitionFormat: 'dd MMM',
                        ),
                      ),
                    ),
                  ),
                  width: 300,
                  height: 250,
                ),
              );
            }
          },
        ),
      ],
    ));
  }
}
