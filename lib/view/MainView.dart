import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/state/MainState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LoginView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
