import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/SkinSettingsView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/AvatarSkinWidget.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/DefaultTextTitle.dart';
import 'package:betsbi/widget/SubmitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkinSettingsState extends State<SkinSettingsView>
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
    defaultFaceIndex = this.widget.faces.lastIndexWhere((face) =>
    face.level.toString() + face.code ==
        this.widget.skinCode.split("_")[0]);
    defaultSkinColorIndex = this.widget.skinColors.lastIndexWhere((color) =>
    color.level.toString() + color.code ==
        this.widget.skinCode.split("_")[1]);
    defaultAccessoryIndex = this.widget.accessories.lastIndexWhere((color) =>
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

  getInformation(){
    faceRequiredLevel = this.widget.faces[defaultFaceIndex].level;
    colorRequiredLevel = this.widget.skinColors[defaultSkinColorIndex].level;
    accessoryRequiredLevel =
        this.widget.accessories[defaultAccessoryIndex].level;
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
                          if (defaultSkinColorIndex < this.widget.skinColors.length - 1)
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
                            hintText: this.widget.faces[defaultFaceIndex]
                                .image
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
                          if (defaultFaceIndex < this.widget.faces.length - 1)
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
                            hintText: this.widget.accessories[defaultAccessoryIndex]
                                .image
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
                          if (defaultAccessoryIndex < this.widget.accessories.length - 1)
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
            AvatarSkinWidget(
              faceImage: this.widget.faces[defaultFaceIndex].image,
              accessoryImage: this.widget.accessories[defaultAccessoryIndex].image,
              skinColor: this.widget.skinColors[defaultSkinColorIndex].colorTable,
            ),
            SizedBox(
              height: 45,
            ),
            isLevelEnough()
                ? SubmitButton(
                    onPressedFunction: () => print("object"),
                    content: "bah voila",
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
