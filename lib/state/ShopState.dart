import 'package:async/async.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/accessorie.dart';
import 'package:betsbi/model/face.dart';
import 'package:betsbi/model/skinColor.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/service/JsonParserManager.dart';
import 'package:betsbi/view/ShopView.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:betsbi/widget/WaitingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ShopState extends State<ShopPage> with WidgetsBindingObserver {
  List<Face> faces;
  List<SkinColor> skinColors;
  List<Accessory> accessories;
  AsyncMemoizer _memorizer = AsyncMemoizer();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    HistoricalManager.addCurrentWidgetToHistorical(this.widget);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _getSkinParametersFromJson() async {
    return this._memorizer.runOnce(() async {
      Map<String, dynamic> mapSkin =
          await JsonParserManager.parseJsonFromAssetsToMap(
              "assets/skin/skin.json");
      faces = new List<Face>();
      skinColors = new List<SkinColor>();
      accessories = new List<Accessory>();
      mapSkin["Face"].forEach((face) {
        face.forEach((faceKey, faceValue) =>
            faces.add(Face.fromJson(key: faceKey, value: faceValue)));
      });
      mapSkin["SkinColor"].forEach((color) {
        color.forEach((colorKey, colorValue) => skinColors
            .add(SkinColor.fromJson(key: colorKey, value: colorValue)));
      });
      mapSkin["Accessories"].forEach((accessory) {
        accessory.forEach((accessoryKey, accessoryValue) => accessories
            .add(Accessory.fromJson(key: accessoryKey, value: accessoryValue)));
      });
      faces.removeWhere((element) => element.level < 30);
      return faces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppSearchBar(),
      bottomNavigationBar: BottomNavigationBarFooter(
        isOffLine: false,
        selectedBottomIndexOnline: null,
      ),
      body: FutureBuilder(
        future: _getSkinParametersFromJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: faces.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Card(
                      child: GestureDetector(
                        onTap: () => print(faces[index].toString()),
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Image.asset(
                              "assets/skin/face/" + faces[index].image),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else
            return WaitingWidget();
        },
      ),
    );
  }

}
