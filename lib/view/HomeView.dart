import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/GridViewHomeWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isPsy;
  HomePage({this.isPsy = false, Key key}) : super(key: key);

  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomePage> with WidgetsBindingObserver {
  int _selectedBottomIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.historical.add(this.widget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridViewHomeWidget(isPsy: this.widget.isPsy),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(_selectedBottomIndex),
    );
  }
}
