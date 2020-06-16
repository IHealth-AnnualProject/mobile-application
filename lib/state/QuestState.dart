import 'package:async/async.dart';
import 'package:betsbi/controller/QuestController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/quest.dart';
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
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestState extends State<QuestPage> with WidgetsBindingObserver {
  List<Widget> listQuestWidget;
  AsyncMemoizer _memorizer = AsyncMemoizer();

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

  getAllUserQuest() {
    return this._memorizer.runOnce(
      () async {
        listQuestWidget = new List<Widget>();
        List<Quest> quests = await QuestController.getAllQuest();
        quests.forEach(
          (quest) => listQuestWidget.add(
            QuestWidget(
              quest: quest,
              parent: this,
            ),
          ),
        );
        return listQuestWidget;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _memorizer = AsyncMemoizer();
    return Scaffold(
      appBar: AppSearchBar(),
      body: FutureBuilder(
          future: getAllUserQuest(),
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
                      title: SettingsManager.mapLanguage["QuestToday"],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    SubmitButton(
                      onPressedFunction: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestCreatePage()),
                      ).whenComplete(() => setState(() {
                            _memorizer = AsyncMemoizer();
                          })),
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
                      itemCount: listQuestWidget.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: listQuestWidget[index],
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
