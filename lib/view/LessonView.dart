import 'package:betsbi/model/lesson.dart';
import 'package:betsbi/state/LessonState.dart';
import 'package:flutter/cupertino.dart';

class LessonView extends StatefulWidget {
  final Lesson lesson;

  LessonView({@required this.lesson});

  @override
  State<LessonView> createState() => LessonState();
}
