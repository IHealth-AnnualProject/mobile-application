import 'dart:async';
import 'package:betsbi/Sqlite/ISQLLITEManager.dart';
import 'package:betsbi/model/memo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLLiteMemos implements ISQLLITEManager {
  Database db;

  @override
  Future openDatabaseandCreateTable() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'betsbi_database.db'),
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, dueDate TEXT)',
        );
        await db.execute(
          'CREATE TABLE message(id INTEGER PRIMARY KEY AUTOINCREMENT, userIdTo TEXT, userIdFrom TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<int> insert(dynamic memo) async {
    memo.id = await db.insert('memo', memo.toMap());
    return memo.id;
  }

  @override
  Future<List<dynamic>> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query('memo');

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
    return await db
        .update('memo', memo.toMap(), where: 'memo = ?', whereArgs: [memo.id]);
  }

  @override
  Future<int> delete(int id) async {
    return await db.delete('memo', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
