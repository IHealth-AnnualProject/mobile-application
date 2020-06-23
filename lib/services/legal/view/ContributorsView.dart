import 'package:betsbi/services/legal/state/ContributorsState.dart';
import 'package:flutter/cupertino.dart';

class ContributorsPage extends StatefulWidget{
  final Map<String, dynamic> content;

  ContributorsPage({@required this.content});

  @override
  State<ContributorsPage> createState() => ContributorsState();

}