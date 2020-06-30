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
