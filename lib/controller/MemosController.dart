import 'package:betsbi/model/memo.dart';
import 'package:betsbi/sqlite/SQLLiteMemos.dart';
import 'package:betsbi/state/IMemoViewState.dart';
import 'package:betsbi/widget/MemosWidget.dart';
import 'package:flutter/cupertino.dart';

class MemosController {
  static Future<int> addNewMemoToMemos(String title, String dueDate) async {
    SQLLiteMemos sqlLiteMemos = new SQLLiteMemos();
    int idMemo;
    await sqlLiteMemos.openDatabaseandCreateTable().then(
          (value) => sqlLiteMemos
              .insert(
                new Memo(
                  title: title,
                  dueDate: dueDate,
                ),
              )
              .then((memoId) => idMemo = memoId),
        );
    return idMemo;
  }

  static Future<void> deleteMemoFromMemos(int id) async {
    SQLLiteMemos sqlLiteMemos = new SQLLiteMemos();
    await sqlLiteMemos
        .openDatabaseandCreateTable()
        .then((value) => sqlLiteMemos.delete(id));
  }

  static Future<List<Widget>> getALlMemos(IMemoViewState parent) async {
    SQLLiteMemos sqlLiteMemos = new SQLLiteMemos();
    List<MemosWidget> list = new List<MemosWidget>();
    await sqlLiteMemos.openDatabaseandCreateTable().then(
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
