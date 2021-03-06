import 'package:betsbi/services/quest/controller/QuestController.dart';
import 'package:betsbi/services/quest/model/quest.dart';
import 'package:betsbi/manager/SettingsManager.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: this.widget.quest.questDescription,
      child : Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: this.widget.quest.questTitle+" ",
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(0, 157, 153, 1),fontFamily: 'PoetsenOne'),
                children: <TextSpan>[
                  TextSpan(text: this.widget.quest.questDifficulty.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
                ],
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
                      ),),
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
    ),);
  }
}
