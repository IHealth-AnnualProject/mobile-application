import 'package:betsbi/state/ExerciseListViewState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListViewPage extends StatefulWidget {
  final String leading;
  final String type;
  ExerciseListViewPage({this.leading, this.type, Key key}) : super(key: key);
  @override
  ExerciseListViewState createState() => ExerciseListViewState();
}
