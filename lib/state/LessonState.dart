import 'package:betsbi/model/pageModel.dart';
import 'package:betsbi/view/LessonView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class LessonState extends State<LessonView> {
  List<PageViewModel> pageModels;

  @override
  void initState() {
    super.initState();
    pageModels = new List<PageViewModel>();
    convertListPageToListPageViewModel(pages: this.widget.lesson.pages);
  }

  void convertListPageToListPageViewModel({@required List<PageModel> pages}) {
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
          mainImage:
              Image.asset(page.mainImage),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(pageModels,
          showNextButton: true,
          showBackButton: true,
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          onTapSkipButton: () => Navigator.of(context).pop(),
          onTapDoneButton: () => Navigator.of(context).pop()),
    );
  }
}
