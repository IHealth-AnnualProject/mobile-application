import 'package:betsbi/controller/QuestController.dart';
import 'package:betsbi/model/quest.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestWidget extends StatefulWidget {
  final Quest quest;
  final State parent;

  QuestWidget({
    @required this.quest,
    @required this.parent,
  });

  @override
  _QuestWidgetState createState() => _QuestWidgetState();
}

class _QuestWidgetState extends State<QuestWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Text(
                this.widget.quest.questTitle,
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1)),
              ),
            ),
            Flexible(
              flex: 5,
              child: Text(
                this.widget.quest.questDifficulty,
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this.widget.quest.questDone == 1
                ? Text(
                    SettingsManager.mapLanguage["Done"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 195, 0, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Flexible(
                    flex: 5,
                    child: RaisedButton(
                      elevation: 8,
                      color: Color.fromRGBO(255, 195, 0, 1),
                      shape: StadiumBorder(
                          side: BorderSide(
                        color: Color.fromRGBO(228, 228, 228, 1),
                      )),
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        await QuestController.validateQuest(
                                context: context,
                                quest : this.widget.quest)
                            .whenComplete(
                                () => this.widget.parent.setState(() {}));
                      },
                      child: Text(
                        SettingsManager.mapLanguage["Done"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 100),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            SizedBox(width: 20,),
            Flexible(
              flex: 5,
              child: RaisedButton(
                elevation: 8,
                color: Color.fromRGBO(255, 195, 0, 1),
                shape: StadiumBorder(
                    side: BorderSide(
                  color: Color.fromRGBO(228, 228, 228, 1),
                )),
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  await QuestController.deleteQuest(
                          context: context, questId: this.widget.quest.questId)
                      .whenComplete(() => this.widget.parent.setState(() {}));
                },
                child: Text(
                  SettingsManager.mapLanguage["Delete"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 100),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
