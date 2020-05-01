import 'package:async/async.dart';
import 'package:betsbi/model/feelings.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class AccountTrace extends StatefulWidget {
  State<AccountTrace> createState() => _AccountTraceState();
}

class _AccountTraceState extends State<AccountTrace> {
  Feelings feelings;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  _fetchData() {
    return this._memoizer.runOnce(() async {
      feelings = new Feelings.normalConstructor();
      await feelings.getUserFeelings();
      return 'REMOTE DATA';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
            alignment: Alignment.topLeft,
            child:
            Text(SettingsManager.mapLanguage["PersonalTrace"],
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.cyan
              ),)),
        Divider(
          color: Colors.cyan,
          thickness: 2,
        ),
        SizedBox(height: 20,),
        FutureBuilder(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              // data loaded:
              return Container(
                child: Echarts(
                  captureAllGestures: true,
                  option: '''
                    {
                      title: {
                        subtextStyle: {
                          align: 'center',
                        },
                        text: 'Feelings of the week',
                      },
                      xAxis: {
                        type: 'category',
                        data: ${feelings.moralDays}
                      },
                      yAxis: {
                        type: 'value'
                      },
                      series: [{
                        data: ${feelings.moralStats},
                        type: 'line'
                      }]
                    }
                  ''',
                ),
                width: 300,
                height: 250,
              );
            }
          },
        ),
      ],
    );
  }
}
