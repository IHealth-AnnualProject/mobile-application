import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/registrationAndLogin/view/LoginView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarOffline extends State<AppSearchBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(SettingsManager.mapLanguage["OfflineMode"]),
      backgroundColor: Color.fromRGBO(0, 116, 113, 1),
      leading: IconButton(
        icon: Icon(CommunityMaterialIcons.logout, color: Colors.white),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
            (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }
}
