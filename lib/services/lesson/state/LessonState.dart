import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/lesson/controller/LessonController.dart';
import 'package:betsbi/services/lesson/view/LessonPage.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class LessonState extends State<LessonView> with WidgetsBindingObserver {
  List<PageViewModel> pageModels;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !this.widget.isOffLine) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
