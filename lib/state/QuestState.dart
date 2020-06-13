import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/QuestCreateView.dart';
import 'package:betsbi/view/QuestView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultCircleAvatar.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/QuestWidget.dart';
import 'package:betsbi/widget/SubmitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestState extends State<QuestPage> with WidgetsBindingObserver {
  List<Widget> list = new List<Widget>();

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
      appBar: AppSearchBar(),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45,
            ),
            DefaultCircleAvatar(
              imagePath: "assets/quest.png",
            ),
            SizedBox(
              height: 45,
            ),
            DefaultTextTitle(
              title: SettingsManager.mapLanguage["QuestToday"],
            ),
            SizedBox(
              height: 45,
            ),
            QuestWidget(
              title: "voila",
              description: "aussi",
              questSate: "easy",
            ),
            SizedBox(
              height: 45,
            ),
            SubmitButton(
              onPressedFunction: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestCreatePage()),
              ),
              content: SettingsManager.mapLanguage["CreateQuest"],
            ),
            SizedBox(
              height: 45,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                SettingsManager.mapLanguage["MyQuestContainer"],
                style: TextStyle(
                    fontSize: 30, color: Color.fromRGBO(0, 157, 153, 1)),
              ),
            ),
            Divider(
              color: Color.fromRGBO(0, 157, 153, 1),
              thickness: 2,
              height: 10,
            ),
            Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: list[index],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarFooter(selectedBottomIndexOffLine: null, selectedBottomIndexOnline: null,),
    );
  }
}
