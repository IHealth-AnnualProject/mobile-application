import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/legal/view/ContributorsView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContributorsState extends State<ContributorsPage>
    with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOnline: null,
        isOffLine: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            DefaultTextTitle(title: SettingsManager.mapLanguage["Contributors"],),
            SizedBox(height: 20,),
            Text(SettingsManager.mapLanguage["HomePage"] + " - " + SettingsManager.mapLanguage["IconAreMadeBy"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text("FreePik",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("MonKik",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Eucalyp",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("SmashIcons",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Pixel-Perfect",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("those-icons",style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
          ],
        ),
      ),
    );
  }
}
