import 'package:betsbi/services/lesson/model/lesson.dart';
import 'package:betsbi/services/lesson/state/LessonState.dart';
import 'package:flutter/cupertino.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;
  final bool isOffLine;

  LessonView({@required this.lesson, this.isOffLine = false});

  @override
  State<LessonView> createState() => LessonState();
}
