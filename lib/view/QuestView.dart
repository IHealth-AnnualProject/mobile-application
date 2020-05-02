import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/QuestCreateView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/QuestWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestPage extends StatefulWidget {
  QuestPage({Key key}) : super(key: key);

  @override
  _QuestView createState() => _QuestView();
}

class _QuestView extends State<QuestPage> {
  List<Widget> list = new List<Widget>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleQuest = Text(
      SettingsManager.mapLanguage["QuestToday"] != null
          ? SettingsManager.mapLanguage["QuestToday"]
          : "",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.cyan[300], fontSize: 40),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.appSearchBarNormal(
          title: SettingsManager.mapLanguage["SearchContainer"] != null
              ? SettingsManager.mapLanguage["SearchContainer"]
              : ""),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 40.0,
                    ),
                  ],
                  color: Colors.cyan,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/quest.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              titleQuest,
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
              RaisedButton(
                elevation: 8,
                color: Color.fromRGBO(104, 79, 37, 0.8),
                shape: StadiumBorder(
                    side: BorderSide(
                      color: Color.fromRGBO(228, 228, 228, 1),
                    )),
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestCreatePage()),
                    );
                  });
                },
                child: Text(
                  SettingsManager.mapLanguage["CreateQuest"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 100),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  SettingsManager.mapLanguage["MyQuestContainer"],
                  style: TextStyle(fontSize: 30, color: Colors.cyan),
                ),
              ),
              Divider(
                color: Colors.cyan,
                thickness: 2,
                height: 10,
              ),
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
        ),
      ),
    );
  }
}
