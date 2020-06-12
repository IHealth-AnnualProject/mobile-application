import 'dart:convert';

import 'package:betsbi/model/lesson.dart';
import 'package:betsbi/model/pageModel.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/LessonView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

class LessonController {
  static Future<String> getJsonLesson({@required BuildContext context}) {
    return DefaultAssetBundle.of(context).loadString('assets/lesson/' +
        SettingsManager.applicationProperties
            .getCurrentLanguage()
            .toLowerCase() +
        '/lessons.json');
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
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LessonView(lesson: lesson)),
            ));
  }

  static List<PageViewModel> convertListPageToListPageViewModel(
      {@required List<PageModel> pages}) {
    List<PageViewModel> pageModels = new List<PageViewModel>();
    pages.forEach(
      (page) => pageModels.add(
        new PageViewModel(
          pageColor: Color.fromRGBO(page.pageColor[0], page.pageColor[1],
              page.pageColor[2], page.pageColor[3].toDouble()),
          bubble: Image.asset(page.bubble),
          body: Text(page.body),
          title: Text(page.title),
          titleTextStyle: TextStyle(color: Colors.white),
          bodyTextStyle: TextStyle(color: Colors.white),
          mainImage: Image.asset(page.mainImage),
        ),
      ),
    );
    return pageModels;
  }
}
