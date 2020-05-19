import 'package:betsbi/state/IntroductionState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  final StatefulWidget destination;

  IntroductionPage({this.destination, Key key}) : super(key: key);

  @override
  IntroductionState createState() {
    return IntroductionState();
  }
}