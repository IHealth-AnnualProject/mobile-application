import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/home/view/HomeView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/GridViewHomeWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
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

  String getBannerAdUnitId()
  {
    if(Platform.isIOS)
      return "ca-app-pub-4901338220117159/8532020232";
    else
      return "ca-app-pub-4901338220117159/9940045640";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            AdmobBanner(
                adUnitId: getBannerAdUnitId(),
                adSize: AdmobBannerSize.BANNER,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  switch (event) {
                    case AdmobAdEvent.loaded:
                      print('Admob banner loaded!');
                      break;

                    case AdmobAdEvent.opened:
                      print('Admob banner opened!');
                      break;

                    case AdmobAdEvent.closed:
                      print('Admob banner closed!');
                      break;

                    case AdmobAdEvent.failedToLoad:
                      print('Admob banner failed to load. Error code: ${args['errorCode']}');
                      break;
                    case AdmobAdEvent.clicked:
                      print('Admob banner closed!');
                      break;
                    case AdmobAdEvent.impression:
                      print('Admob banner closed!');
                      break;
                    case AdmobAdEvent.leftApplication:
                      print('Admob banner closed!');
                      break;
                    case AdmobAdEvent.completed:
                      print('Admob banner closed!');
                      break;
                    case AdmobAdEvent.rewarded:
                      print('Admob banner closed!');
                      break;
                    case AdmobAdEvent.started:
                      print('Admob banner closed!');
                      break;
                  }
                }
            ),
            Expanded(
              child: GridViewHomeWidget(isPsy: this.widget.isPsy),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(selectedBottomIndexOffLine: null, selectedBottomIndexOnline: 0,),
    );
  }
}
