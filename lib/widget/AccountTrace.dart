import 'package:async/async.dart';
import 'package:betsbi/model/feelings.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class AccountTrace extends StatefulWidget {
  final User profile;

  AccountTrace({Key key, @required this.profile}) : super(key: key);

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
      await feelings.getUserFeelings(this.widget.profile.profileId, context);
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
    final titleAccount = Text(
      this.widget.profile.username + " lv.1",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
    );
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 45,
        ),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                offset: Offset(1.0, 6.0),
                blurRadius: 40.0,
              ),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/user.png"),
            ),
          ),
        ),
        SizedBox(
          height: 45,
        ),
        titleAccount,
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              // data loaded:
              //print(feelings.moralDays);
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
    ));
  }
}
