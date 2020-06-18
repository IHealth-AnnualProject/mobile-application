import 'package:betsbi/model/accessorie.dart';
import 'package:betsbi/model/face.dart';
import 'package:betsbi/model/skinColor.dart';
import 'package:betsbi/state/SkinSettingsState.dart';
import 'package:flutter/cupertino.dart';

class SkinSettingsView extends StatefulWidget {
  final int level;
  final String skinCode;
  final List<Face> faces;
  final List<SkinColor> skinColors;
  final List<Accessory> accessories;

  SkinSettingsView(
      {@required this.level,
      @required this.skinCode,
      @required this.faces,
      @required this.accessories,
      @required this.skinColors});

  @override
  State<SkinSettingsView> createState() => SkinSettingsState();
}
