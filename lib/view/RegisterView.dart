import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/RegisterController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/LoginView.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FeelingsView.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterView createState() => _RegisterView();
}

class _RegisterView extends State<RegisterPage> {
  List<bool> _isSelected = [true, false];
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool registrating;

  @override
  Widget build(BuildContext context) {

    final username = TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      controller: userNameController,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["UsernameText"] != null
              ? SettingsManager.mapLanguage["UsernameText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["UsernameText"] != null
              ? SettingsManager.mapLanguage["UsernameText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final password = TextFormField(
      obscureText: true,
      textAlign: TextAlign.left,
      controller: passwordController,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["PasswordText"] != null
              ? SettingsManager.mapLanguage["PasswordText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["PasswordText"] != null
              ? SettingsManager.mapLanguage["PasswordText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final confirmPassword = TextFormField(
      obscureText: true,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        if(value != passwordController.text){
          return SettingsManager.mapLanguage["NotSamePassword"] != null
              ? SettingsManager.mapLanguage["NotSamePassword"]
              : "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["ConfirmPassword"] != null
              ? SettingsManager.mapLanguage["ConfirmPassword"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["ConfirmPassword"] != null
              ? SettingsManager.mapLanguage["ConfirmPassword"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final email = TextFormField(
      obscureText: false,
      textAlign: TextAlign.left,
      validator: (value) {
        return CheckController.checkEmail(value);
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: SettingsManager.mapLanguage["EmailText"] != null
              ? SettingsManager.mapLanguage["EmailText"]
              : "",
          filled: true,
          fillColor: Colors.white,
          hintText: SettingsManager.mapLanguage["EmailText"] != null
              ? SettingsManager.mapLanguage["EmailText"]
              : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final statusUser = ToggleButtons(
      color: Colors.white,
      fillColor: Colors.blue,
      borderRadius: BorderRadius.circular(16.0),
      children: <Widget>[
        Text(
          SettingsManager.mapLanguage["UserChoice"] != null
              ? SettingsManager.mapLanguage["UserChoice"]
              : "",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          SettingsManager.mapLanguage["PsyChoice"] != null
              ? SettingsManager.mapLanguage["PsyChoice"]
              : "",
          style: TextStyle(color: Colors.white),
        )
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _isSelected[buttonIndex] = true;
            } else {
              _isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: _isSelected,
    );
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 228, 228, 1),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(child: username, width: 350),
                          SizedBox(
                            height: 45,
                          ),
                          Container(child: email, width: 350),
                          SizedBox(
                            height: 45,
                          ),
                          Container(child: password, width: 350),
                          SizedBox(
                            height: 45,
                          ),
                          Container(child: confirmPassword, width: 350),
                          SizedBox(
                            height: 45,
                          ),
                          Text(
                            SettingsManager.mapLanguage["CheckBoxPsy"] != null
                                ? SettingsManager.mapLanguage["CheckBoxPsy"]
                                : "",
                              style: TextStyle(color: Colors.cyan[300],fontSize: 17),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          statusUser,
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: finalButton(
                                SettingsManager.mapLanguage["DoneButton"] !=
                                        null
                                    ? SettingsManager.mapLanguage["DoneButton"]
                                    : "",
                                SettingsManager.mapLanguage["RegisterSent"] !=
                                        null
                                    ? SettingsManager
                                        .mapLanguage["RegisterSent"]
                                    : "",
                                FeelingsPage()),
                            width: 350,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  RaisedButton finalButton(
      String title, String content, StatefulWidget destination) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () async {
        if (this._formKey.currentState.validate()) {
          registrating = await RegisterController.register(
              userNameController.text, passwordController.text, _isSelected[1]);
          if (registrating)
            finalFlushBar(
                Icon(
                  Icons.done_outline,
                  color: Colors.yellow,
                ),
                content)
              ..show(context).then((r) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false,));
          else
            finalFlushBar(
                    Icon(
                      Icons.not_interested,
                      color: Colors.red,
                    ),
                    SettingsManager.mapLanguage["WentWrong"] != null
                        ? SettingsManager.mapLanguage["WentWrong"]
                        : "")
                .show(context);
        }
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Flushbar finalFlushBar(Icon icon, String message) {
    return Flushbar(
      icon: icon,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      message: message,
      duration: Duration(seconds: 1),
    );
  }
}
