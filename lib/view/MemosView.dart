import 'package:betsbi/view/MemosCreateView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/widget/MemosWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemosPage extends StatefulWidget {
  MemosPage({Key key}) : super(key: key);

  @override
  _MemosView createState() => _MemosView();
}

class _MemosView extends State<MemosPage> {
  List<Widget> list = new List<Widget>();

  @override
  void initState() {
    super.initState();
    list.add(new MemosWidget(
      title: "Ranger les chaussettes",
      isDone: false,
    ));
    list.add(new MemosWidget(
      title: "Manger les chaussures",
      isDone: false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final titleMemos = Text(
      SettingsManager.mapLanguage["MemosList"] != null
          ? SettingsManager.mapLanguage["MemosList"]
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
                  image: AssetImage("assets/notes.png"),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            titleMemos,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemosCreatePage()));
              },
              child: Text(
                SettingsManager.mapLanguage["CreateMemos"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 100),
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: list[index],
                  );
                }),
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
