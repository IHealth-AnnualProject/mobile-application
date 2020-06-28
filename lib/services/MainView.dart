import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:betsbi/services/MainState.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(getAppId());
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

String getAppId() {
  if (Platform.isIOS)
    return "ca-app-pub-4901338220117159~8615780719";
  else
    return "ca-app-pub-4901338220117159~3938169107";
}

class MainPage extends StatefulWidget {
  @override
  MainState createState() => new MainState();
}
