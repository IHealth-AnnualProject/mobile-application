import 'package:betsbi/services/account/model/accessorie.dart';
import 'package:betsbi/services/account/model/face.dart';
import 'package:betsbi/services/account/model/skinColor.dart';
import 'package:betsbi/services/account/state/SkinSettingsState.dart';
import 'package:flutter/cupertino.dart';

class SkinSettingsPage extends StatefulWidget {
  final int level;
  final String skinCode;

  SkinSettingsPage(
      {@required this.level,
      @required this.skinCode});

  @override
  State<SkinSettingsPage> createState() => SkinSettingsState();
}
