import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/widget/FlushBarError.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  UserProfile userProfile;
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userProfile.getUserProfile();
  }

  TextFormField accountFormField(
      {dynamic initialValue,
      TextInputType inputType,
      String labelAndHintText,
      TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      textAlign: TextAlign.left,
      initialValue: initialValue,
      validator: (value) {
        if (value.isEmpty) {
          return SettingsManager.mapLanguage["EnterText"] != null
              ? SettingsManager.mapLanguage["EnterText"]
              : "";
        }
        return null;
      },
      keyboardType: inputType,
      decoration: InputDecoration(
          labelText: labelAndHintText != null ? labelAndHintText : "",
          filled: true,
          fillColor: Colors.white,
          hintText: labelAndHintText != null ? labelAndHintText : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
  }

  RaisedButton finalButton(
      {String barContent, StatefulWidget destination, String buttonContent}) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        if (this._formKey.currentState.validate()) {
          if (userProfile.updateUserProfile(
              firstname: firstNameController.text,
              lastname: lastNameController.text,
              age: int.parse(ageController.text))) {
            Flushbar(
              icon: Icon(
                Icons.done_outline,
                color: Colors.yellow,
              ),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.GROUNDED,
              message: barContent,
              duration: Duration(seconds: 1),
            )..show(context).then((r) => () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => destination),
                      ModalRoute.withName('/'));
                });
          } else
            FlushBarError(SettingsManager.mapLanguage["WentWrong"] != null
                ? SettingsManager.mapLanguage["WentWrong"]
                : "");
        }
      },
      child: Text(
        buttonContent,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 100),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
                child: accountFormField(
                    initialValue: userProfile.firstName,
                    labelAndHintText:
                        SettingsManager.mapLanguage["FirstNameText"],
                    inputType: TextInputType.text,
                    controller: firstNameController),
                width: 350),
            SizedBox(
              height: 45,
            ),
            Container(
                child: accountFormField(
                    initialValue: userProfile.lastName,
                    labelAndHintText:
                        SettingsManager.mapLanguage["LastNameText"],
                    inputType: TextInputType.text,
                    controller: lastNameController),
                width: 350),
            SizedBox(
              height: 45,
            ),
            Container(
                child: accountFormField(
                    initialValue: userProfile.age,
                    labelAndHintText: "Age",
                    inputType: TextInputType.number,
                    controller: ageController),
                width: 350),
            SizedBox(
              height: 45,
            ),
            Container(
                child: finalButton(
                  buttonContent: SettingsManager.mapLanguage["Submit"] != null
                      ? SettingsManager.mapLanguage["Submit"]
                      : "",
                  destination: AccountPage(),
                  barContent:
                      SettingsManager.mapLanguage["UpdateUserInformation"] !=
                              null
                          ? SettingsManager.mapLanguage["UpdateUserInformation"]
                          : "",
                ),
                width: 350),
          ],
        ));
  }
}
