import 'package:betsbi/state/ReportState.dart';
import 'package:flutter/cupertino.dart';

class ReportView extends StatefulWidget{
  final String userName;
  final String userId;

  ReportView({@required this.userName, @required this.userId});

  @override
  State<ReportView> createState() => ReportState();

}