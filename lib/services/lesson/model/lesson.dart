import 'package:betsbi/services/introduction/model/pageModel.dart';

class Lesson {
  final String name;
  final List<PageModel> pages;

  Lesson({this.name, this.pages});

  factory Lesson.fromJsonToLesson(Map<String, dynamic> json) {
    var pages = json['Pages'] as List;
    List<PageModel> pagesList = pages.map((i) => PageModel.fromJson(i)).toList();
    return Lesson(
      name: json['Name'],
      pages: pagesList,
    );
  }
}
