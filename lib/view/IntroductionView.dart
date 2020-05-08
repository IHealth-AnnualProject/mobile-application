import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'HomeView.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionState createState() {
    return _IntroductionState();
  }
}

class _IntroductionState extends State<IntroductionPage> {
  final pages = [
    PageViewModel(
      pageColor: Color.fromRGBO(71, 215, 240, 1),
      bubble: Image.asset('assets/user.png'),
      body: Text(
        SettingsManager.mapLanguage["UserIntroduction"],
      ),
      title: Text(
        SettingsManager.mapLanguage["User"],
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
      mainImage: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 6.0),
              blurRadius: 40.0,
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/user.png"),
          ),
        ),
      ),
    ),
    PageViewModel(
      pageColor: Color.fromRGBO(88, 214, 141, 1),
      iconImageAssetPath: 'assets/quest.png',
      body: Text(
        SettingsManager.mapLanguage["QuestIntroduction"],
      ),
      title: Text(SettingsManager.mapLanguage["Quest"]),
      mainImage: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 6.0),
              blurRadius: 40.0,
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/quest.png"),
          ),
        ),
      ),
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
      mainImage: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 6.0),
              blurRadius: 40.0,
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/training.png"),
          ),
        ),
      ),
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
      mainImage: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 6.0),
              blurRadius: 40.0,
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/exercise.png"),
          ),
        ),
      ),
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
      mainImage: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 6.0),
              blurRadius: 40.0,
            ),
          ],
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/emergency.png"),
          ),
        ),
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
                        builder: (context) => HomePage(),
                      ), //MaterialPageRoute
                    )),
        onTapDoneButton: () =>
            SettingsManager.updateValueOfConfigurationSecureStorage(
                    "firstEntry", "false")
                .then((_) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ), //MaterialPageRoute
                    )),
      ),
    );
  }
}
