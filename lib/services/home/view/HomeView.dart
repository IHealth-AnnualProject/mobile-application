import 'package:betsbi/services/home/HomeState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isPsy;
  HomePage({this.isPsy = false, Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}