import 'package:async/async.dart';
import 'package:betsbi/model/feelings.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class AccountTrace extends StatefulWidget {
  final UserProfile userProfile;

  AccountTrace({Key key, @required this.userProfile}) : super(key: key);

  State<AccountTrace> createState() => _AccountTraceState();
}

class _AccountTraceState extends State<AccountTrace> {
  Feelings feelings;
  AsyncMemoizer _memorizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  _fetchData() {
    return this._memorizer.runOnce(() async {
      feelings = new Feelings.normalConstructor();
      await feelings.getUserFeelings(this.widget.userProfile.userProfileId);
      setState(() {});
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
    return Column(
      children: <Widget>[
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              // data loaded:
              print(this.widget.userProfile.userProfileId + "voila");
              return Card(
                elevation: 10,
                child: Container(
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
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
