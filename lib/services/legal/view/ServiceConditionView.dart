import 'package:betsbi/services/legal/state/ServiceConditionState.dart';
import 'package:flutter/cupertino.dart';

class ServiceConditionPage extends StatefulWidget{
  final Map<String, dynamic> content;

  ServiceConditionPage({@required this.content});

  @override
  State<ServiceConditionPage> createState() => ServiceConditionState();

}