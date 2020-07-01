import 'dart:ui';
import 'package:async/async.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/global/controller/CheckController.dart';
import 'package:betsbi/services/account/model/psychologist.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:betsbi/services/chat/view/ChatView.dart';
import 'package:betsbi/services/account/view/SkinSettingsView.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_map_place/search_map_place.dart';

import '../view/AccountInformationView.dart';

class AccountInformationState extends State<AccountInformationPage> {
  var userProfile;
  final _formKey = GlobalKey<FormState>();
  Widget currentUserWidget;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController ageController;
  TextEditingController descriptionController;
  String locationController;
  AsyncMemoizer _memorizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    if (!this.widget.isPsy)
      userProfile = new UserProfile.defaultConstructor();
    else
      userProfile = new Psychologist.defaultConstructor();
  }

  Future<void> userInformation() async {
    if (this.widget.isPsy) {
      await userProfile.getUserProfile(userID: this.widget.profile.profileId);
      setState(() {
        firstNameController = new TextEditingController()
          ..text = userProfile.firstName;
        lastNameController = new TextEditingController()
          ..text = userProfile.lastName;
        ageController = new TextEditingController()
          ..text = userProfile.birthdate;
        descriptionController = new TextEditingController()
          ..text = userProfile.description;
        locationController = userProfile.geolocation;
      });
    } else {
      await userProfile.getUserProfile(userID: this.widget.profile.profileId);
      setState(() {
        ageController = new TextEditingController()
          ..text = userProfile.birthdate.toString();
        descriptionController = new TextEditingController()
          ..text = userProfile.description;
      });
    }
  }

  Container accountFormField(
      {TextInputType inputType,
      String labelAndHintText,
      TextEditingController controller,
        Widget icon,
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
        validator: (value) => CheckController.checkField(value),
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelAndHintText != null ? labelAndHintText : "",
          filled: true,
          icon: icon,
          fillColor: Colors.white,
          hintText: labelAndHintText != null ? labelAndHintText : "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
    return result;
  }


  _getSkinParametersFromJsonAndCurrentIndexForSkin() async {
    return this._memorizer.runOnce(() async {
      await userInformation();
      return currentUserWidget =
          AccountController.getUserAvatarAccordingToHisIdForAccount(
              user: userProfile, context: context);
    });
  }

  Future<void> updateInformation() async {
    if (this.widget.isPsy)
      await userProfile.updateProfile(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          birthdate: ageController.text,
          description: descriptionController.text,
          profileId: this.widget.profile.profileId,
          isPsy: this.widget.isPsy,
          geolocation: locationController,
          context: context);
    else
      await userProfile.updateProfile(
          birthdate: ageController.text,
          description: descriptionController.text,
          profileId: this.widget.profile.profileId,
          isPsy: this.widget.isPsy,
          context: context);
  }

  RaisedButton finalButton({String barContent, String buttonContent}) {
    return RaisedButton(
      elevation: 8,
      shape: StadiumBorder(),
      color: Color.fromRGBO(255, 195, 0, 1),
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () async {
        if (this._formKey.currentState.validate()) {
          await updateInformation().whenComplete(() => this.setState(() {
            _memorizer = AsyncMemoizer();
          }));
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
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _getSkinParametersFromJsonAndCurrentIndexForSkin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 45,
                  ),
                  SettingsManager.applicationProperties.getCurrentId() ==
                          this.widget.profile.profileId
                      ? GestureDetector(
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SkinSettingsPage(
                                    level: userProfile.level,
                                    skinCode: userProfile.skin,
                                  ),
                                ),
                              ).whenComplete(
                                () => this.setState(
                                  () {
                                    _memorizer = AsyncMemoizer();
                                  },
                                ),
                              ),
                          child: currentUserWidget)
                      : currentUserWidget,
                  SizedBox(
                    height: 45,
                  ),
                  DefaultTextTitle(
                    title: this.widget.profile.username +
                        " lv." +
                        this.widget.profile.level.toString(),
                  ),
                  SizedBox(
                    height: 45,
                  ),
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
                  Visibility(
                    visible: this.widget.isPsy,
                    child: Column(
                      children: <Widget>[
                        accountFormField(
                            labelAndHintText:
                                SettingsManager.mapLanguage["FirstNameText"],
                            inputType: TextInputType.text,
                            controller: firstNameController,
                            icon: Icon(Icons.person),
                            maxLength: 100),
                        SizedBox(
                          height: 45,
                        ),
                        accountFormField(
                            labelAndHintText:
                                SettingsManager.mapLanguage["LastNameText"],
                            inputType: TextInputType.text,
                            controller: lastNameController,
                            icon: Icon(Icons.person),
                            maxLength: 100),
                        SizedBox(
                          height: 45,
                        ),
                        IgnorePointer(
                          ignoring: this.widget.isReadOnly,
                          child: Container(
                            width: 350,
                            child: SearchMapPlaceWidget(
                              icon: Icons.location_on,
                              apiKey: SettingsManager.cfg.getString("apiKey"),
                              placeholder:
                                  userProfile.geolocation.toString().isEmpty
                                      ? SettingsManager
                                          .mapLanguage["AddressSelector"]
                                      : locationController.split("||")[0],
                              language: SettingsManager.applicationProperties
                                  .getCurrentLanguage()
                                  .toLowerCase(),
                              onSelected: (place) async => locationController =
                                  place.description +
                                      "||" +
                                      (await place.geolocation)
                                          .coordinates
                                          .latitude
                                          .toString() +
                                      "," +
                                      (await place.geolocation)
                                          .coordinates
                                          .longitude
                                          .toString(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 350,
                    child: TextFormField(
                      controller: ageController,
                      obscureText: false,
                      maxLines: 1,
                      readOnly: this.widget.isReadOnly,
                      onTap: () => _selectDate(),
                      textAlign: TextAlign.left,
                      validator: (value) {
                        if (value.isEmpty) {
                          return SettingsManager.mapLanguage["EnterText"] !=
                                  null
                              ? SettingsManager.mapLanguage["EnterText"]
                              : "";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: SettingsManager.mapLanguage["Birthdate"],
                          filled: true,
                          icon: Icon(Icons.date_range),
                          fillColor: Colors.white,
                          hintText: SettingsManager.mapLanguage["Birthdate"],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0))),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  accountFormField(
                      labelAndHintText:
                          SettingsManager.mapLanguage["Description"],
                      maxLine: 10,
                      inputType: TextInputType.text,
                      controller: descriptionController,
                      maxLength: 300),
                  SizedBox(
                    height: 45,
                  ),
                  SettingsManager.applicationProperties.getCurrentId() ==
                          this.widget.profile.profileId
                      ? Container(
                          child: finalButton(
                            buttonContent:
                                SettingsManager.mapLanguage["Submit"] != null
                                    ? SettingsManager.mapLanguage["Submit"]
                                    : "",
                            barContent: SettingsManager
                                        .mapLanguage["UpdateUserInformation"] !=
                                    null
                                ? SettingsManager
                                    .mapLanguage["UpdateUserInformation"]
                                : "",
                          ),
                          width: 350)
                      : RaisedButton(
                          elevation: 8,
                          shape: StadiumBorder(),
                          color: Color.fromRGBO(255, 195, 0, 1),
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                userContactedId: this.widget.profile.profileId,
                                userContactedName: this.widget.profile.username,
                              ),
                            ),
                          ),
                          child: Text(
                            "Contact",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 100),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ],
              ),
            );
          } else
            return WaitingWidget();
        },
      ),
    );
  }

  Future _selectDate() async {
    if (SettingsManager.applicationProperties.getCurrentId() ==
        this.widget.profile.profileId) {
      DateTime picked = await showDatePicker(
          context: context,
          initialDate: new DateTime(1920),
          firstDate: new DateTime(1920),
          lastDate: new DateTime(DateTime.now().year));
      if (picked != null)
        setState(
            () => ageController.text = DateFormat('yyyy-MM-dd').format(picked));
    }
  }
}
