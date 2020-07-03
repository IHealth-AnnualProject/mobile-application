import 'dart:convert';

import 'package:betsbi/services/lesson/model/lesson.dart';
import 'package:betsbi/services/introduction/model/pageModel.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/lesson/view/LessonPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

class LessonController {
  static Future<List<Widget>> getJsonLesson(
      {@required BuildContext context}) async {
    String jsonToDecode = await DefaultAssetBundle.of(context).loadString(
        'assets/lesson/' +
            SettingsManager.applicationProperties
                .getCurrentLanguage()
                .toLowerCase() +
            '/lessons.json');
    return LessonController.decodeJsonAndStoreItInsideLessonList(
        jsonToDecode: jsonToDecode, context: context);
  }

  static List<Widget> decodeJsonAndStoreItInsideLessonList(
      {@required String jsonToDecode, @required BuildContext context}) {
    List<Widget> listWidgetLesson = List<Widget>();
    Iterable listFromJson = json.decode(jsonToDecode);
    List<Lesson> lessons = new List<Lesson>();
    lessons.addAll(
        listFromJson.map((model) => Lesson.fromJsonToLesson(model)).toList());
    lessons.forEach(
      (element) {
        listWidgetLesson.add(
          lesson(lesson: element, context: context),
        );
      },
    );
    return listWidgetLesson;
  }

  static ListTile lesson(
      {@required Lesson lesson, @required BuildContext context}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage("assets/notes.png"),
      ),
      title: Text(lesson.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LessonView(
            lesson: lesson,
          ),
        ),
      ),
    );
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
