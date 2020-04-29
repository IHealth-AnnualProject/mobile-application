import 'package:betsbi/model/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class AccountTrace extends StatefulWidget {
  State<AccountTrace> createState() => _AccountTraceState();
}

class _AccountTraceState extends State<AccountTrace> {
  UserProfile userProfile;
  final List<int> feelingsPoint = [0, 1, 2, 3, 4, 5, 6];

  @override
  void initState() {
    super.initState();
    userProfile = new UserProfile.defaultConstructor();
    userProfile.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Echarts(
        captureAllGestures: true,
        option: '''
                    {
                      title: {
                        subtextStyle: {
                          align: 'center',
                        },
                        text: 'Feelings in the week',
                      },
                      xAxis: {
                        type: 'category',
                        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      },
                      yAxis: {
                        type: 'value'
                      },
                      series: [{
                        data: $feelingsPoint,
                        type: 'line'
                      }]
                    }
                  ''',
      ),
      width: 300,
      height: 250,
    );
  }
}
