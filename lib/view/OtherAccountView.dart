import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherAccountPage extends StatefulWidget {
  final UserProfile otherUserProfile;

  OtherAccountPage({Key key, @required this.otherUserProfile}) : super(key: key);

  @override
  _OtherAccountView createState() => _OtherAccountView();
}

class _OtherAccountView extends State<OtherAccountPage>  {

  @override
  void dispose() {
    super.dispose();
  }

  TextField textFieldInformation({String label, int maxLine}) {
    return TextField(
      readOnly: true,
      maxLines: maxLine != null ? maxLine : 1,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final titleAccount = Text(
      this.widget.otherUserProfile.username + " lv.1",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(104, 79, 37, 0.8),
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.AppSearchBarNormal(
        title: SettingsManager.mapLanguage["SearchContainer"] != null
            ? SettingsManager.mapLanguage["SearchContainer"]
            : "",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                  color: Color.fromRGBO(104, 79, 37, 0.8),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/user.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              titleAccount,
              Container(
                  child: textFieldInformation(label: this.widget.otherUserProfile.firstName),
                  width: 350),
              SizedBox(
                height: 45,
              ),
              Container(
                  child: textFieldInformation(label: this.widget.otherUserProfile.lastName),
                  width: 350),
              SizedBox(
                height: 45,
              ),
              Container(
                  child: textFieldInformation(label: this.widget.otherUserProfile.age),
                  width: 100),
              SizedBox(
                height: 45,
              ),
              Container(
                  child: textFieldInformation(label: this.widget.otherUserProfile.description, maxLine: 10),
                  width: 350),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }
}
