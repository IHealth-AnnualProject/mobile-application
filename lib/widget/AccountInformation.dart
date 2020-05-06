import 'dart:ui';

import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/widget/FlushBarError.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  final bool isReadOnly;
  final bool isPsy;
  final String profileID;
  AccountInformation(
      {@required this.isReadOnly, this.isPsy, this.profileID, Key key})
      : super(key: key);

  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  var userProfile;
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController ageController;
  TextEditingController descriptionController;
  bool isEntered = false;

  @override
  void initState() {
    super.initState();
    if (!this.widget.isPsy)
      userProfile = new UserProfile.defaultConstructor();
    else
      userProfile = new Psychologist.defaultConstructor();
  }

  void userInformation() async {
    if (this.widget.isPsy) {
      await userProfile.getUserProfile(userID: this.widget.profileID);
      setState(() {
        firstNameController = new TextEditingController()
          ..text = userProfile.firstName;
        lastNameController = new TextEditingController()
          ..text = userProfile.lastName;
        ageController = new TextEditingController()
          ..text = userProfile.birthdate;
        descriptionController = new TextEditingController()
          ..text = userProfile.description;
      });
    } else {
      await userProfile.getUserProfile(userID: this.widget.profileID);
      setState(() {
        ageController = new TextEditingController()
          ..text = userProfile.birthdate.toString();
        descriptionController = new TextEditingController()
          ..text = userProfile.description;
      });
    }
    isEntered = true;
  }

  Container accountFormField(
      {TextInputType inputType,
      String labelAndHintText,
      TextEditingController controller,
      int maxLine,
      int maxLength}) {
    Container result;
    result = Container(
      width: 350,
      child: TextFormField(
        controller: controller,
        obscureText: false,
        maxLines: maxLine == null ? 1 : maxLine,
        maxLength: maxLength,
        readOnly: this.widget.isReadOnly,
        textAlign: TextAlign.left,
        validator: (value) {
          if (value.isEmpty) {
            return SettingsManager.mapLanguage["EnterText"] != null
                ? SettingsManager.mapLanguage["EnterText"]
                : "";
          }
          if (maxLength == 3 && int.parse(value) > 120) {
            return SettingsManager.mapLanguage["TooOld"];
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
      ),
    );
    return result;
  }

  RaisedButton finalButton({String barContent, String buttonContent}) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(255, 195, 0, 1),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () async {
        if (this._formKey.currentState.validate()) {
          if (await userProfile.updateUserProfile(
              firstname: firstNameController.text,
              lastname: lastNameController.text,
              birthdate: int.parse(ageController.text),
              description: descriptionController.text,
              isPsy: this.widget.isPsy)) {
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
                        builder: (BuildContext context) => AccountPage(
                              userId: this.widget.profileID,
                              isPsy: this.widget.isPsy,
                            )),
                    (Route<dynamic> route) => false,
                  );
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
    if (!isEntered) userInformation();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              SettingsManager.mapLanguage["PersonalInformation"],
              style: TextStyle(
                  fontSize: 30, color: Color.fromRGBO(0, 157, 153, 1)),
            ),
          ),
          Divider(
            color: Color.fromRGBO(0, 157, 153, 1),
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          this.widget.isPsy
              ? accountFormField(
                  labelAndHintText:
                      SettingsManager.mapLanguage["FirstNameText"],
                  inputType: TextInputType.text,
                  controller: firstNameController,
                  maxLength: 100)
              : Container(),
          SizedBox(
            height: 45,
          ),
          this.widget.isPsy
              ? accountFormField(
                  labelAndHintText: SettingsManager.mapLanguage["LastNameText"],
                  inputType: TextInputType.text,
                  controller: lastNameController,
                  maxLength: 100)
              : Container(),
          SizedBox(
            height: 45,
          ),
          accountFormField(
              labelAndHintText: "Age",
              inputType: TextInputType.number,
              controller: ageController,
              maxLength: 3),
          SizedBox(
            height: 45,
          ),
          accountFormField(
              labelAndHintText: SettingsManager.mapLanguage["Description"],
              maxLine: 10,
              inputType: TextInputType.text,
              controller: descriptionController,
              maxLength: 300),
          SizedBox(
            height: 45,
          ),
          SettingsManager.currentId == this.widget.profileID
              ? Container(
                  child: finalButton(
                    buttonContent: SettingsManager.mapLanguage["Submit"] != null
                        ? SettingsManager.mapLanguage["Submit"]
                        : "",
                    barContent: SettingsManager
                                .mapLanguage["UpdateUserInformation"] !=
                            null
                        ? SettingsManager.mapLanguage["UpdateUserInformation"]
                        : "",
                  ),
                  width: 350)
              : Container(
                  child: Text("UPCOMING"),
                ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
