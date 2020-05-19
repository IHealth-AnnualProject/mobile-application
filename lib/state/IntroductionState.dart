import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/IntroductionView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroductionState extends State<IntroductionPage> {

  @override
  void initState(){
    super.initState();
  }

  final pages = [
    PageViewModel(
      pageColor: Color.fromRGBO(128, 195, 241, 1),
      bubble: Image.asset('assets/user.png'),
      body: Text(
        SettingsManager.mapLanguage["UserIntroduction"],
      ),
      title: Text(
        SettingsManager.mapLanguage["User"],
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset("assets/introduction/introduction_account.png"),
    ),
    PageViewModel(
      pageColor: Color.fromRGBO(88, 214, 141, 1),
      iconImageAssetPath: 'assets/quest.png',
      body: Text(
        SettingsManager.mapLanguage["QuestIntroduction"],
      ),
      title: Text(SettingsManager.mapLanguage["Quest"]),
      mainImage: Image.asset("assets/introduction/introduction_quest.png"),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromRGBO(243, 223, 63, 1),
      iconImageAssetPath: 'assets/training.png',
      body: Text(
        SettingsManager.mapLanguage["TrainingIntroduction"],
      ),
      title: Text(SettingsManager.mapLanguage["Training"]),
      mainImage: Image.asset("assets/introduction/introduction_exercice.png"),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromRGBO(208, 167, 229, 1),
      iconImageAssetPath: 'assets/exercise.png',
      body: Text(
        SettingsManager.mapLanguage["AmbianceIntroduction"],
      ),
      title: Text(SettingsManager.mapLanguage["Ambiance"]),
      mainImage: Image.asset("assets/introduction/introduction_music.png"),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromRGBO(128, 195, 241, 1),
      iconImageAssetPath: 'assets/emergency.png',
      body: Text(
        SettingsManager.mapLanguage["ChatIntroduction"],
      ),
      title: Text(SettingsManager.mapLanguage["Chat"]),
      mainImage: Image.asset(
        "assets/introduction/introduction_chat.png",
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
        onTapSkipButton: () =>
            SettingsManager.updateValueOfConfigurationSecureStorage(
                "firstEntry", "false")
                .then((_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => this.widget.destination,
              ), //MaterialPageRoute
            )),
        onTapDoneButton: () =>
            SettingsManager.updateValueOfConfigurationSecureStorage(
                "firstEntry", "false")
                .then((_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => this.widget.destination,
              ), //MaterialPageRoute
            )),
      ),
    );
  }
}
