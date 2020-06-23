import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/legal/view/ServiceConditionView.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceConditionState extends State<ServiceConditionPage>
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
            DefaultTextTitle(title: SettingsManager.mapLanguage["ServiceCondition"],),
            SizedBox(height: 20,),
            Text("Article 1 : " + SettingsManager.mapLanguage["Subject"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["Subject"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 2 : " + SettingsManager.mapLanguage["LegalMention"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["LegalMention"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 3 : " + SettingsManager.mapLanguage["Access"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["Access"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 4 : " + SettingsManager.mapLanguage["DataCollect"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["DataCollect"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 5 : " + SettingsManager.mapLanguage["IntellectualProperty"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["IntellectualProperty"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 6 : " + SettingsManager.mapLanguage["Responsibility"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["Responsibility"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 7 : " + SettingsManager.mapLanguage["ContractDuration"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["ContractDuration"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
            SizedBox(height: 20,),
            Text("Article 8 : " + SettingsManager.mapLanguage["ApplicableLawAndJurisdiction"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromRGBO(0, 157, 153, 1)),),
            Divider(thickness: 2,),
            Text(this.widget.content["ApplicableLawAndJurisdiction"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(0, 157, 153, 1)),),
          ],
        ),
      ),
    );
  }
}
