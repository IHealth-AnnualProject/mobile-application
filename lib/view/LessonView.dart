import 'package:betsbi/model/lesson.dart';
import 'package:betsbi/state/LessonState.dart';
import 'package:flutter/cupertino.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;
  final bool isOffLine;

  LessonView({@required this.lesson, this.isOffLine = false});

  @override
  State<LessonView> createState() => LessonState();
}
