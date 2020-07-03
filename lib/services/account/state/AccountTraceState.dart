import 'package:async/async.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/view/AccountTraceView.dart';
import 'package:betsbi/services/feeling/controller/FeelingController.dart';
import 'package:betsbi/services/feeling/model/feelings.dart';
import 'package:betsbi/tools/DefaultCircleAvatar.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AccountTraceState extends State<AccountTracePage> {
  AsyncMemoizer _memorizer = AsyncMemoizer();

  List<charts.Series<Feelings, DateTime>> _createSampleData(
      List<Feelings> feelings) {
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

  getAllFeelings() => this
      ._memorizer
      .runOnce(() async => await FeelingController.getAllFeelings(
            this.widget.profile.profileId,
            context,
          ));

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
            title: this.widget.profile.username +
                " lv." +
                this.widget.profile.level.toString(),
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
            ),
          ),
          Divider(
            color: Color.fromRGBO(0, 157, 153, 1),
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: getAllFeelings(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return WaitingWidget();
               else {
                // data loaded:
                return Card(
                  elevation: 10,
                  child: Container(
                    child: charts.TimeSeriesChart(
                      _createSampleData(snapshot.data),
                      animate: false,
                      dateTimeFactory: charts.LocalDateTimeFactory(),
                      domainAxis: charts.DateTimeAxisSpec(
                        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                          day: charts.TimeFormatterSpec(
                            format: 'dd',
                            transitionFormat: 'dd MMM',
                          ),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 20,
                    height: 250,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
