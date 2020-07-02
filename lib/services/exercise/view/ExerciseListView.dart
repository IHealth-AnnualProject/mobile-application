import 'package:betsbi/services/exercise/state/ExerciseListState.dart';
import 'package:betsbi/services/exercise/state/ExerciseListStateOffline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListPage extends StatefulWidget {
  final String leading;
  final String type;
  final bool isOffLine;
  ExerciseListPage(
      {this.leading, this.type, this.isOffLine = false, Key key})
      : super(key: key);
  @override
  State<ExerciseListPage> createState() => isOffLine ? ExerciseListStateOffline() : ExerciseListState();
}
