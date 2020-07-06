import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/quest/controller/QuestController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/quest/view/QuestCreateView.dart';
import 'package:betsbi/services/quest/view/QuestView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultCircleAvatar.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestState extends State<QuestPage> with WidgetsBindingObserver {

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
      body: FutureBuilder(
          future: QuestController.getAllQuest(parent: this),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      title: SettingsManager.mapLanguage["MyQuestContainer"],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    SubmitButton(
                      onPressedFunction: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestCreatePage()),
                      ).whenComplete(() => setState(() {})),
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
                            fontSize: 30,
                            color: Color.fromRGBO(0, 157, 153, 1)),
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(0, 157, 153, 1),
                      thickness: 2,
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: snapshot.data[index],
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            else
              return WaitingWidget();
          }),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
    );
  }
}
