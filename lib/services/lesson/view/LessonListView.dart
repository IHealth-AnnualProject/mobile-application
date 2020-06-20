import 'package:betsbi/services/lesson/LessonListState.dart';
import 'package:flutter/cupertino.dart';

class LessonListView extends StatefulWidget{

  final bool isOffLine;

  LessonListView({this.isOffLine = false});


  @override
  State<LessonListView> createState() => LessonListState();

}