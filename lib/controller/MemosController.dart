import 'package:betsbi/model/memo.dart';
import 'package:betsbi/model/notification.dart';
import 'package:betsbi/service/NotificationManager.dart';
import 'package:betsbi/service/SQLLiteManager.dart';
import 'package:betsbi/service/SettingsManager.dart';
import 'package:betsbi/sqlite/SQLLITeNotification.dart';
import 'package:betsbi/sqlite/SQLLiteMemos.dart';
import 'package:betsbi/state/MemoViewState.dart';
import 'package:betsbi/widget/MemosWidget.dart';
import 'package:flutter/cupertino.dart';

class MemosController {
  static Future<int> addNewMemoToMemos(String title, String dueDate) async {
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

  static Future<List<Widget>> getALlMemos(MemosViewState parent) async {
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
