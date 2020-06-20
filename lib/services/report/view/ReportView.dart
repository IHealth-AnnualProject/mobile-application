import 'package:betsbi/services/report/state/ReportState.dart';
import 'package:flutter/cupertino.dart';

class ReportPage extends StatefulWidget{
  final String userName;
  final String userId;

  ReportPage({@required this.userName, @required this.userId});

  @override
  State<ReportPage> createState() => ReportState();

}