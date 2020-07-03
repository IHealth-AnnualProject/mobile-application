import 'package:betsbi/manager/HttpManager.dart';
import 'package:betsbi/manager/ResponseManager.dart';
import 'package:betsbi/services/quest/model/quest.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/quest/SQLLiteQuest.dart';
import 'package:betsbi/tools/FlushBarMessage.dart';
import 'package:betsbi/services/quest/widget/QuestWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestController {
  static int getExperienceAccordingToDifficulty(
      {@required String questDifficulty}) {
    int calculatedExperienceGained = 0;
    switch (questDifficulty.toLowerCase()) {
      case "easy":
        calculatedExperienceGained = 10;
        break;
      case "normal":
        calculatedExperienceGained = 25;
        break;
      case "hard":
        calculatedExperienceGained = 50;
        break;
    }
    return calculatedExperienceGained;
  }

  static Future<List<Quest>> getAllQuestFromBDD() async {
    SQLLiteQuest sqlLiteQuest = new SQLLiteQuest();
    List<Quest> quests = new List<Quest>();
    quests = await sqlLiteQuest.getAll();
    return quests;
  }

  static Future<void> createQuest(
      {@required BuildContext context,
      @required String questTitle,
      @required String questDifficulty,
      @required String questDescription}) async {
    SQLLiteQuest sqlLiteQuest = new SQLLiteQuest();
    int insertReturn = await sqlLiteQuest.insert(new Quest(
        questDescription: questDescription,
        questDifficulty: questDifficulty,
        questTitle: questTitle,
        userId: SettingsManager.applicationProperties.getCurrentId(),
    questDone: 0));
    if (insertReturn != null)
      FlushBarMessage.goodMessage(
              content: SettingsManager.mapLanguage["QuestCreated"])
          .showFlushBar(context);
    else
      FlushBarMessage.errorMessage(
              content: SettingsManager.mapLanguage["QuestNotCreated"])
          .showFlushBar(context);
  }

  static Future<void> validateQuest(
      {@required BuildContext context, @required Quest quest}) async {
    SQLLiteQuest sqlLiteQuest = new SQLLiteQuest();
    quest.changeDone(1);
    int updateReturn = await sqlLiteQuest.update(quest);
    if (updateReturn != null) {
      await sendXpGainedByUser(context : context,questDifficulty: quest.questDifficulty);
      showCongratsDialog(context: context, questDifficulty: quest.questDifficulty);
    }
    else
      FlushBarMessage.errorMessage(
              content: SettingsManager.mapLanguage["QuestNotCreated"])
          .showFlushBar(context);
  }

  static Future<void> deleteQuest(
      {@required BuildContext context, @required int questId}) async {
    SQLLiteQuest sqlLiteQuest = new SQLLiteQuest();
    int deleteReturn = await sqlLiteQuest.delete(questId);
    if (deleteReturn != null)
      FlushBarMessage.goodMessage(
              content: SettingsManager.mapLanguage["QuestDeleted"])
          .showFlushBar(context);
    else
      FlushBarMessage.errorMessage(
              content: SettingsManager.mapLanguage["QuestNotDeleted"])
          .showFlushBar(context);
  }

  static Future<void> sendXpGainedByUser({@required BuildContext context, @required String questDifficulty})
  async {
    HttpManager httpManager =
    new HttpManager(path: 'user/addXp', context: context,map: {"xp":getExperienceAccordingToDifficulty(questDifficulty: questDifficulty)});
    await httpManager.post();
    ResponseManager responseManager = new ResponseManager(
      response: httpManager.response,
      context: context,
    );
     responseManager.checkResponseAndExecuteFunctionIfOk();
  }

  static showCongratsDialog({BuildContext context, String questDifficulty}) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Image.asset("assets/congrats.gif"),
      ),
      content: Text.rich(
        TextSpan(
          text: SettingsManager.mapLanguage["CongratsBegin"],
          style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 17),
          children: [
            TextSpan(
              text: getExperienceAccordingToDifficulty(
                      questDifficulty: questDifficulty)
                  .toString(),
              style: TextStyle(
                  color: Color.fromRGBO(0, 157, 153, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            TextSpan(
              text: SettingsManager.mapLanguage["CongratsEnd"],
              style: TextStyle(
                  color: Color.fromRGBO(0, 157, 153, 1), fontSize: 17),
            ),
          ],
        ),
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<List<Widget>> getAllQuest({@required State parent}) async
  {
    List<Widget> listQuestWidget =  List<Widget>();
    List<Quest> quests = await QuestController.getAllQuestFromBDD();
    quests.removeWhere((quest) => quest.userId != SettingsManager.applicationProperties.getCurrentId());
    quests.forEach(
          (quest) => listQuestWidget.add(
        QuestWidget(
          quest: quest,
          parent: parent,
        ),
      ),
    );
    return listQuestWidget;
  }
}
