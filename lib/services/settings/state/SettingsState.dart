import 'package:betsbi/manager/HistoricalManager.dart';
import 'package:betsbi/manager/NotificationManager.dart';
import 'package:betsbi/services/global/controller/TokenController.dart';
import 'package:betsbi/services/settings/controller/SettingsController.dart';
import 'package:betsbi/services/global/model/notification.dart';
import 'package:betsbi/services/settings/SQLLITeNotification.dart';
import 'package:betsbi/services/settings/view/SettingsView.dart';
import 'package:betsbi/tools/AppSearchBar.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/tools/BottomNavigationBarFooter.dart';
import 'package:betsbi/tools/DefaultCircleAvatar.dart';
import 'package:betsbi/tools/SubmitButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsState extends State<SettingsPage> with WidgetsBindingObserver {
  String currentNotification;
  List<bool> isSelected = [true, false];

  void _setLanguage() {
    SettingsManager.setLanguage().then((r) => setState(() {}));
  }

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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      TokenController.checkTokenValidity(context).then((result) {
        if (!result) SettingsController.disconnect(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentNotification =
        SettingsManager.applicationProperties.areNotificationPushActivated();
    if (currentNotification == 'true')
      isSelected = [true, false];
    else
      isSelected = [false, true];
    final statusPushNotification = ToggleButtons(
      color: Colors.white,
      fillColor: Colors.blue,
      borderRadius: BorderRadius.circular(16.0),
      children: <Widget>[
        Text(
          "ON",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "OFF",
          style: TextStyle(color: Colors.white),
        )
      ],
      onPressed: (int index) async {
        if (index == 0) {
          await SettingsManager.setNotificationPush("true");
          SQLLiteNotification sqlLiteNotification = new SQLLiteNotification();
          List<LocalNotification> list = new List<LocalNotification>();
          list = await sqlLiteNotification.getAll();
          list.forEach(
              (notification) => NotificationManager.scheduleNotification(
                    title: notification.notificationTitle,
                    body: notification.notificationBody,
                    id: notification.notificationId,
                    dueDate: notification.notificationDate,
                  ));
          // todo schedule notification push for all memos in db
          setState(() {});
        } else {
          await SettingsManager.setNotificationPush("false");
          await NotificationManager.cancelAllNotifications();
          setState(() {});
        }

        setState(() {});
      },
      isSelected: isSelected,
    );
    final language = InkWell(
      onTap: () => _setLanguage(),
      child: new Text(
        SettingsManager.applicationProperties.getLanguage() != null
            ? SettingsManager.applicationProperties.getLanguage()
            : "",
        textAlign: TextAlign.center,
        style: TextStyle(color: Color.fromRGBO(0, 157, 153, 1), fontSize: 40),
      ),
    );
    return Scaffold(
      appBar: AppSearchBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 45,
          ),
          DefaultCircleAvatar(
            imagePath: "assets/settings.png",
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                SettingsManager.mapLanguage["LanguageChanged"] != null
                    ? SettingsManager.mapLanguage["LanguageChanged"]
                    : "",
                style: TextStyle(
                    color: Color.fromRGBO(0, 157, 153, 1), fontSize: 25),
              ),
              SizedBox(
                width: 20,
              ),
              language,
            ],
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                SettingsManager.mapLanguage["NotificationPushActivated"] != null
                    ? SettingsManager.mapLanguage["NotificationPushActivated"]
                    : "",
                style: TextStyle(
                    color: Color.fromRGBO(0, 157, 153, 1), fontSize: 25),
              ),
              statusPushNotification
            ],
          ),
          SizedBox(
            height: 45,
          ),
          SubmitButton(
            onPressedFunction: () =>
                SettingsController.reloadIntroductionPage(context),
            content: SettingsManager.mapLanguage["ReloadIntroduction"],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: SubmitButton(
                  onPressedFunction: () =>
                      SettingsController.disconnect(context),
                  content: SettingsManager.mapLanguage["Logout"],
                ),
                width: 350,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarFooter(
        selectedBottomIndexOffLine: null,
        selectedBottomIndexOnline: null,
      ),
    );
  }
}
