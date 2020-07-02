import 'package:betsbi/services/lesson/state/LessonListState.dart';
import 'package:flutter/cupertino.dart';

class LessonListPage extends StatefulWidget{

  final bool isOffLine;

  LessonListPage({this.isOffLine = false});


  @override
  State<LessonListPage> createState() => LessonListState();

}