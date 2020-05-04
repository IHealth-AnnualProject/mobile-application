import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherAccountPage extends StatefulWidget {
  final UserProfile otherUserProfile;

  OtherAccountPage({Key key, @required this.otherUserProfile})
      : super(key: key);

  @override
  _OtherAccountView createState() => _OtherAccountView();
}

class _OtherAccountView extends State<OtherAccountPage> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity()
          .then((result) => result == false ?? SettingsController.disconnect(context));
    }
  }

  TextField textFieldInformation({String label, int maxLine}) {
    return TextField(
      readOnly: true,
      maxLines: maxLine != null ? maxLine : 1,
      decoration: InputDecoration(
        fillColor: Color.fromRGBO(228, 228, 228, 1),
        labelText: label,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final titleAccount = Text(
      this.widget.otherUserProfile.username + " lv.1",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.cyan[300], fontSize: 40),
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 228, 228, 1),
      appBar: AppSearchBar.appSearchBarNormal(
        title: SettingsManager.mapLanguage["SearchContainer"] != null
            ? SettingsManager.mapLanguage["SearchContainer"]
            : "",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                    image: AssetImage("assets/user.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              titleAccount,
              SizedBox(
                height: 45,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    SettingsManager.mapLanguage["PersonalInformation"],
                    style: TextStyle(fontSize: 30, color: Colors.cyan),
                  )),
              Divider(
                color: Colors.cyan,
                thickness: 2,
              ),
              // Or No Information or Informations
              SizedBox(
                height: 20,
              ),
              _checkAllUserProperties()
                  ? Center(
                      child: Text(
                        SettingsManager.mapLanguage["NoInformation"],
                        style: TextStyle(color: Colors.cyan, fontSize: 17),
                      ),
                    )
                  : informationOtherUserAccount(),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBarFooter(null),
    );
  }

  bool _checkAllUserProperties() {
    if (this.widget.otherUserProfile.firstName == "" &&
        this.widget.otherUserProfile.lastName == "" &&
        this.widget.otherUserProfile.age == "" &&
        this.widget.otherUserProfile.description == "") {
      return true;
    }
    return false;
  }

  Column informationOtherUserAccount() {
    return Column(children: <Widget>[
      this.widget.otherUserProfile.firstName == "" ??
          Container(
              child: textFieldInformation(
                  label: this.widget.otherUserProfile.firstName),
              width: 350),
      SizedBox(
        height: 45,
      ),
      this.widget.otherUserProfile.lastName == "" ??
          Container(
              child: textFieldInformation(
                  label: this.widget.otherUserProfile.lastName),
              width: 350),
      SizedBox(
        height: 45,
      ),
      this.widget.otherUserProfile.age == "" ??
          Container(
              child:
                  textFieldInformation(label: this.widget.otherUserProfile.age),
              width: 100),
      SizedBox(
        height: 45,
      ),
      this.widget.otherUserProfile.description == "" ??
          Container(
              child: textFieldInformation(
                  label: this.widget.otherUserProfile.description, maxLine: 10),
              width: 350),
    ]);
  }
}
