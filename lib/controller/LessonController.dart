import 'dart:convert';

import 'package:betsbi/model/lesson.dart';
import 'package:betsbi/view/LessonView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonController {
  static Future<String> getJsonLesson({@required BuildContext context}) {
    return DefaultAssetBundle.of(context)
        .loadString('assets/lesson/lessons.json');
  }

  static List<Lesson> decodeJsonAndStoreItInsideLessonList(
      String jsonToDecode, List<Widget> inputList, BuildContext context) {
    Iterable listFromJson = json.decode(jsonToDecode);
    List<Lesson> lessons = new List<Lesson>();
    lessons.addAll(
        listFromJson.map((model) => Lesson.fromJsonToLesson(model)).toList());
    lessons.forEach(
      (element) {
        inputList.add(
          lesson(lesson: element, context: context),
        );
      },
    );
    return lessons;
  }

  static ListTile lesson({Lesson lesson, BuildContext context}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage("assets/notes.png"),
      ),
      title: Text(lesson.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LessonView(lesson: lesson)),
        );
      },
    );
  }
}
