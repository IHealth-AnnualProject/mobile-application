import 'package:betsbi/controller/CheckController.dart';
import 'package:betsbi/controller/RegisterController.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/FeelingsView.dart';
import 'package:betsbi/view/RegisterView.dart';
import 'package:betsbi/widget/TextFormFieldCustomBetsBi.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterState extends State<RegisterPage> {
  List<bool> _isSelected = [true, false];
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      Container(
                          child: TextFormFieldCustomBetsBi(
                            obscureText: false,
                            textAlign: TextAlign.left,
                            controller: userNameController,
                            validator: (value) => CheckController.checkField(value),
                            labelText:
                                SettingsManager.mapLanguage["UsernameText"],
                            filled: true,
                            fillColor: Colors.white,
                            hintText:
                                SettingsManager.mapLanguage["UsernameText"],
                          ),
                          width: 350),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                          child: TextFormFieldCustomBetsBi(
                            obscureText: true,
                            textAlign: TextAlign.left,
                            controller: emailController,
                            validator: (value) => CheckController.checkField(
                                value,
                                emailToCheck: value),
                            keyBoardType: TextInputType.emailAddress,
                            labelText: SettingsManager.mapLanguage["EmailText"],
                            filled: true,
                            fillColor: Colors.white,
                            hintText: SettingsManager.mapLanguage["EmailText"],
                          ),
                          width: 350),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                          child: TextFormFieldCustomBetsBi(
                            obscureText: true,
                            textAlign: TextAlign.left,
                            controller: passwordController,
                            validator: (value) => CheckController.checkField(value),
                            labelText:
                                SettingsManager.mapLanguage["PasswordText"],
                            filled: true,
                            fillColor: Colors.white,
                            hintText:
                                SettingsManager.mapLanguage["PasswordText"],
                          ),
                          width: 350),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                          child: TextFormFieldCustomBetsBi(
                            obscureText: true,
                            textAlign: TextAlign.left,
                            controller: confirmPasswordController,
                            validator: (value) => CheckController.checkField(
                                value,
                                passwordToCheck: passwordController.text),
                            labelText:
                                SettingsManager.mapLanguage["ConfirmPassword"],
                            filled: true,
                            fillColor: Colors.white,
                            hintText:
                                SettingsManager.mapLanguage["ConfirmPassword"],
                          ),
                          width: 350),
                      SizedBox(
                        height: 45,
                      ),
                      Text(
                        SettingsManager.mapLanguage["CheckBoxPsy"] != null
                            ? SettingsManager.mapLanguage["CheckBoxPsy"]
                            : "",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 157, 153, 1),
                            fontSize: 17),
                        textAlign: TextAlign.center,
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
                            SettingsManager.mapLanguage["DoneButton"] != null
                                ? SettingsManager.mapLanguage["DoneButton"]
                                : "",
                            SettingsManager.mapLanguage["RegisterSent"] != null
                                ? SettingsManager.mapLanguage["RegisterSent"]
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
      color: Color.fromRGBO(255, 195, 0, 1),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () async {
        if (this._formKey.currentState.validate()) {
          await RegisterController.register(userNameController.text,
              passwordController.text, _isSelected[1], context);
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
