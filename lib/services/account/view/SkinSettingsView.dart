import 'package:betsbi/services/account/model/accessorie.dart';
import 'package:betsbi/services/account/model/face.dart';
import 'package:betsbi/services/account/model/skinColor.dart';
import 'package:betsbi/services/account/state/SkinSettingsState.dart';
import 'package:flutter/cupertino.dart';

class SkinSettingsPage extends StatefulWidget {
  final int level;
  final String skinCode;
  final List<Face> faces;
  final List<SkinColor> skinColors;
  final List<Accessory> accessories;

  SkinSettingsPage(
      {@required this.level,
      @required this.skinCode,
      @required this.faces,
      @required this.accessories,
      @required this.skinColors});

  @override
  State<SkinSettingsPage> createState() => SkinSettingsState();
}
