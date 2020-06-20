import 'package:betsbi/services/lesson/LessonController.dart';
import 'package:betsbi/services/lesson/LessonView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class LessonState extends State<LessonView> {
  List<PageViewModel> pageModels;

  @override
  void initState() {
    super.initState();
    pageModels = LessonController.convertListPageToListPageViewModel(
        pages: this.widget.lesson.pages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
        pageModels,
        showNextButton: true,
        showBackButton: true,
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        onTapSkipButton: () => Navigator.of(context).pop(),
        onTapDoneButton: () => Navigator.of(context).pop(),
      ),
    );
  }
}
