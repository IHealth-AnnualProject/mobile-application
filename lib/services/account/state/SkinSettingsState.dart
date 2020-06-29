import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/account/controller/SkinController.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';

import 'package:betsbi/services/account/view/SkinSettingsView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/AvatarSkinWidget.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultTextTitle.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkinSettingsState extends State<SkinSettingsPage>
    with WidgetsBindingObserver {
  int defaultFaceIndex = 0;
  int defaultSkinColorIndex = 0;
  int defaultAccessoryIndex = 0;
  int faceRequiredLevel;
  int colorRequiredLevel;
  int accessoryRequiredLevel;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    defaultFaceIndex = SkinController.faces.lastIndexWhere((face) =>
        face.level.toString() + face.code ==
        this.widget.skinCode.split("_")[0]);
    defaultSkinColorIndex = SkinController.skinColors.lastIndexWhere((color) =>
        color.level.toString() + color.code ==
        this.widget.skinCode.split("_")[1]);
    defaultAccessoryIndex = SkinController.accessories.lastIndexWhere((color) =>
        color.level.toString() + color.code ==
        this.widget.skinCode.split("_")[2]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  getInformation() {
    faceRequiredLevel = SkinController.faces[defaultFaceIndex].level;
    colorRequiredLevel = SkinController.skinColors[defaultSkinColorIndex].level;
    accessoryRequiredLevel =
        SkinController.accessories[defaultAccessoryIndex].level;
  }

  @override
  Widget build(BuildContext context) {
    getInformation();
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOnline: null,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            DefaultTextTitle(
              title:
                  "Choisissez le skin que vous souhaitez afficher sur l'application",
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Table(
                columnWidths: {1: FractionColumnWidth(.5)},
                children: [
                  TableRow(
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (defaultSkinColorIndex > 0)
                            setState(() {
                              defaultSkinColorIndex--;
                            });
                        },
                        child: Icon(
                          Icons.navigate_before,
                          color: Colors.white,
                        ),
                      ),
                      TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: defaultSkinColorIndex.toString()),
                      ),
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (defaultSkinColorIndex <
                              SkinController.skinColors.length - 1)
                            setState(() {
                              defaultSkinColorIndex++;
                            });
                        },
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  TableRow(children: [
                    SizedBox(height: 15), //SizeBox Widget
                    SizedBox(height: 15),
                    SizedBox(height: 15),
                  ]),
                  TableRow(
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (defaultFaceIndex > 0)
                            setState(() {
                              defaultFaceIndex--;
                            });
                        },
                        child: Icon(
                          Icons.navigate_before,
                          color: Colors.white,
                        ),
                      ),
                      TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: SkinController
                                .faces[defaultFaceIndex].image
                                .replaceAll(".png", "")),
                      ),
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (defaultFaceIndex <
                              SkinController.faces.length - 1)
                            setState(() {
                              defaultFaceIndex++;
                            });
                        },
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  TableRow(children: [
                    SizedBox(height: 15), //SizeBox Widget
                    SizedBox(height: 15),
                    SizedBox(height: 15),
                  ]),
                  TableRow(
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (defaultAccessoryIndex > 0)
                            setState(() {
                              defaultAccessoryIndex--;
                            });
                        },
                        child: Icon(
                          Icons.navigate_before,
                          color: Colors.white,
                        ),
                      ),
                      TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: SkinController
                                .accessories[defaultAccessoryIndex].image
                                .replaceAll(".png", "")),
                      ),
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if (defaultAccessoryIndex <
                              SkinController.accessories.length - 1)
                            setState(() {
                              defaultAccessoryIndex++;
                            });
                        },
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            AvatarSkinWidget.accountConstructor(
              faceImage: SkinController.faces[defaultFaceIndex].image,
              accessoryImage:
                  SkinController.accessories[defaultAccessoryIndex].image,
              skinColor:
                  SkinController.skinColors[defaultSkinColorIndex].colorTable,
            ),
            SizedBox(
              height: 45,
            ),
            isLevelEnough()
                ? SubmitButton(
                    onPressedFunction: () async =>
                        await SkinController.updateSkinForCurrentUser(
                            skinCode: SkinController
                                    .faces[defaultFaceIndex].level
                                    .toString() +
                                "" +
                                SkinController.faces[defaultFaceIndex].code +
                                "_" +
                                SkinController
                                    .skinColors[defaultSkinColorIndex].level
                                    .toString() +
                                "" +
                                SkinController
                                    .skinColors[defaultSkinColorIndex].code +
                                "_" +
                                SkinController
                                    .accessories[defaultAccessoryIndex].level
                                    .toString() +
                                "" +
                                SkinController
                                    .accessories[defaultAccessoryIndex].code,
                            context: context),
                    content: SettingsManager.mapLanguage["Submit"],
                  )
                : Text("Required Level :" + requiredLevel().toString()),
          ],
        )),
      ),
    );
  }

  bool isLevelEnough() {
    return this.widget.level >= colorRequiredLevel &&
        this.widget.level >= faceRequiredLevel &&
        this.widget.level >= accessoryRequiredLevel;
  }

  int requiredLevel() {
    int level = 0;
    if (colorRequiredLevel >= faceRequiredLevel &&
        colorRequiredLevel >= accessoryRequiredLevel)
      level = colorRequiredLevel;
    if (faceRequiredLevel >= colorRequiredLevel &&
        faceRequiredLevel >= accessoryRequiredLevel) level = faceRequiredLevel;
    if (accessoryRequiredLevel >= faceRequiredLevel &&
        accessoryRequiredLevel >= colorRequiredLevel)
      level = accessoryRequiredLevel;
    return level;
  }
}
