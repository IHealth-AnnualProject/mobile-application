import 'package:admob_flutter/admob_flutter.dart';
import 'package:betsbi/manager/PubManager.dart';
import 'package:betsbi/services/MainState.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PubManager pubManager = new PubManager();
  Admob.initialize(pubManager.getAppId());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      MaterialApp(
        theme: ThemeData(fontFamily: 'PoetsenOne'),
        home: MainPage(),
        builder: (BuildContext context, Widget widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return LoginPage();
          };
          return widget;
        },
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  MainState createState() => new MainState();
}
