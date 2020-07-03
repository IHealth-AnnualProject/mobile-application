import 'package:betsbi/manager/NotificationManager.dart';
import 'package:betsbi/manager/SQLLiteManager.dart';
import 'package:betsbi/services/memo/model/memo.dart';
import 'package:betsbi/services/global/model/notification.dart';
import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/settings/SQLLITeNotification.dart';
import 'package:betsbi/services/memo/SQLLiteMemos.dart';
import 'package:betsbi/services/memo/state/MemoState.dart';
import 'package:betsbi/tools/MemosWidget.dart';
import 'package:flutter/cupertino.dart';

class MemosController {
  static Future<int> addNewMemoToMemos({@required String title, @required String dueDate}) async {
    SQLLiteMemos sqlLiteMemos = new SQLLiteMemos();
    SQLLiteNotification sqlLiteNotification = new SQLLiteNotification();
    int idMemo;
    await SQLLiteManager.openDatabaseAndCreateTable().then(
      (value) => sqlLiteMemos
          .insert(
            new Memo(
              title: title,
              dueDate: dueDate,
            ),
          )
          .then((memoId) => idMemo = memoId),
    );
    await sqlLiteNotification.insert(LocalNotification(
        notificationId: idMemo,
        notificationTitle: SettingsManager.mapLanguage["Memos"],
        notificationBody: title,
        notificationType: "Memos",
        notificationDate: dueDate));
    await NotificationManager.scheduleNotification(title: SettingsManager.mapLanguage["Memos"], body: title, id: idMemo, dueDate: dueDate);
    return idMemo;
  }

  static Future<void> deleteMemoFromMemos(int id) async {
    SQLLiteMemos sqlLiteMemos = new SQLLiteMemos();
    SQLLiteNotification sqlLiteNotification = new SQLLiteNotification();
    await SQLLiteManager.openDatabaseAndCreateTable()
        .then((value) => sqlLiteMemos.delete(id));
    int notificationIdDeleted = await sqlLiteNotification.deleteByIdWithType(id, "Memos");
    await NotificationManager.cancelNotification(notificationIdDeleted);
  }

  static Future<List<Widget>> getALlMemos(MemosState parent) async {
    SQLLiteMemos sqlLiteMemos = new SQLLiteMemos();
    List<MemosWidget> list = new List<MemosWidget>();
    await SQLLiteManager.openDatabaseAndCreateTable().then(
      (value) => sqlLiteMemos.getAll().then(
            (listMemos) => listMemos.forEach(
              (memo) => list.add(
                new MemosWidget(
                  title: memo.title,
                  dueDate: memo.dueDate,
                  id: memo.id,
                  parent: parent,
                ),
              ),
            ),
          ),
    );
    return list;
  }
}
