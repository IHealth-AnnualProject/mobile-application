import 'package:betsbi/model/newMessage.dart';
import 'package:betsbi/sqlite/ISQLLITEManager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLLiteNewMessage implements ISQLLITEManager {
  Database _db;

  @override
  Future close() async => _db.close();

  @override
  Future<int> delete(int id) async {
    await openDatabaseandCreateTable();
    return await _db.delete('message', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteById(String userIdFrom) async {
    await openDatabaseandCreateTable();
    return await _db
        .delete('message', where: 'userIdFrom = ?', whereArgs: [userIdFrom]);
  }

  Future<int> countByIdTo(String userIdTo) async {
    await openDatabaseandCreateTable();
    return Sqflite.firstIntValue(
      await _db
          .rawQuery('SELECT COUNT(*) FROM message WHERE userIdTo = "$userIdTo"'),
    );
  }

  Future<int> countByIdFromAndTo({String userIdFrom, String userIdTo}) async {
    await openDatabaseandCreateTable();
    return Sqflite.firstIntValue(
      await _db.rawQuery(
          'SELECT COUNT(*) FROM message WHERE userIdTo = "$userIdTo" And userIdFrom = "$userIdFrom"'),
    );
  }

  @override
  Future<List<NewMessage>> getAll() async {
    await openDatabaseandCreateTable();
    final List<Map<String, dynamic>> maps = await _db.query('message');

    return List.generate(maps.length, (i) {
      return NewMessage(
        userIdFrom: maps[i]['userIdFrom'],
        userIdTo: maps[i]['userIdTo'],
      );
    });
  }

  @override
  Future<int> insert(dynamic newMessage) async {
    await openDatabaseandCreateTable();
    newMessage.id = await _db.insert('message', newMessage.toMap());
    return newMessage.id;
  }

  @override
  Future openDatabaseandCreateTable() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'betsbi_database.db'),
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE message(id INTEGER PRIMARY KEY AUTOINCREMENT, userIdTo TEXT, userIdFrom TEXT)',
        );
        await db.execute(
          'CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, dueDate TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<int> update(dynamic message) async {
    return await _db.update('message', message.toMap(),
        where: 'id = ?', whereArgs: [message.id]);
  }
}
