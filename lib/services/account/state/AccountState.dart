import 'package:async/async.dart';
import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/services/account/controller/AccountController.dart';
import 'package:betsbi/services/account/model/tabContent.dart';
import 'package:betsbi/services/account/model/user.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/account/model/psychologist.dart';
import 'package:betsbi/services/account/model/userProfile.dart';
import 'package:betsbi/services/account/view/AccountView.dart';
import 'package:betsbi/tools/AppBarWithTabs.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/WaitingWidget.dart';
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
      await profile.getUserProfile(
        userID: this.widget.userId,
        context: context,
      );
      actualContentPage =
          AccountController.getTabBarAndViewAccordingToUserTypeAndId(
        user: profile,
      );
      return profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: findUserInformation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppSearchBar(),
            body: WaitingWidget(),
            bottomNavigationBar: BottomNavigationBarFooter(
              selectedBottomIndexOffLine: null,
              selectedBottomIndexOnline: 1,
            ),
          );
        } else {
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
              bottomNavigationBar: BottomNavigationBarFooter(
                selectedBottomIndexOffLine: null,
                selectedBottomIndexOnline: 1,
              ),
            ),
          );
        }
      },
    );
  }
}
