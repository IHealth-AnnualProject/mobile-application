import 'package:betsbi/state/ExerciseListViewState.dart';
import 'package:betsbi/state/ExerciseListViewStateOffline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListViewPage extends StatefulWidget {
  final String leading;
  final String type;
  final bool isOffLine;
  ExerciseListViewPage(
      {this.leading, this.type, this.isOffLine = false, Key key})
      : super(key: key);
  @override
  State<ExerciseListViewPage> createState() => isOffLine ? ExerciseListViewStateOffline() : ExerciseListViewState();
}
