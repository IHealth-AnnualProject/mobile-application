import 'package:async/async.dart';
import 'package:betsbi/controller/AccountController.dart';
import 'package:betsbi/controller/SettingsController.dart';
import 'package:betsbi/controller/TokenController.dart';
import 'package:betsbi/model/psychologist.dart';
import 'package:betsbi/model/tabContent.dart';
import 'package:betsbi/model/user.dart';
import 'package:betsbi/model/userProfile.dart';
import 'package:betsbi/service/HistoricalManager.dart';
import 'package:betsbi/view/AccountView.dart';
import 'package:betsbi/widget/AppBarWithTabs.dart';
import 'package:betsbi/widget/AppSearchBar.dart';
import 'package:betsbi/widget/BottomNavigationBarFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountState extends State<AccountPage> with WidgetsBindingObserver {
  User profile;
  final AsyncMemoizer _memorizer = AsyncMemoizer();
  TabContent actualContentPage;

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
    if (!this.widget.isPsy)
      profile = new UserProfile.defaultConstructor();
    else
      profile = new Psychologist.defaultConstructor();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  findUserInformation() {
    return this._memorizer.runOnce(() async {
      await profile.getUserProfile(userID: this.widget.userId);
      setState(() {});
      return profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: findUserInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppSearchBar(),
            body: Center(child: CircularProgressIndicator()),
            bottomNavigationBar: BottomNavigationBarFooter(1),
          );
        } else {
          actualContentPage =
              AccountController.getTabBarAndViewAccordingToUserTypeAndId(
                  user: profile);
          return DefaultTabController(
            length: actualContentPage.tabText.length,
            child: Scaffold(
              appBar: AppBarWithTabs(
                tabText: actualContentPage.tabText,
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: TabBarView(children: actualContentPage.tabWidget),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBarFooter(1),
            ),
          );
        }
      },
    );
  }
}
