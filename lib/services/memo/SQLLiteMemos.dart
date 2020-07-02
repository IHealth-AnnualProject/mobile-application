import 'dart:async';
import 'package:betsbi/manager/SQLLiteManager.dart';
import 'package:betsbi/services/global/ISQLLITEManager.dart';
import 'package:betsbi/services/memo/model/memo.dart';

class SQLLiteMemos implements ISQLLITEManager {

  @override
  Future<int> insert(dynamic memo) async {
    memo.id = await SQLLiteManager.db.insert('memo', memo.toMap());
    return memo.id;
  }

  @override
  Future<List<Memo>> getAll() async {
    final List<Map<String, dynamic>> maps = await SQLLiteManager.db.query('memo');
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        dueDate: maps[i]['dueDate'],
      );
    });
  }

  @override
  Future<int> update(dynamic memo) async {
    return await SQLLiteManager.db
        .update('memo', memo.toMap(), where: 'memo = ?', whereArgs: [memo.id]);
  }

  @override
  Future<int> delete(int id) async {
    return await SQLLiteManager.db.delete('memo', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async => SQLLiteManager.db.close();
}
