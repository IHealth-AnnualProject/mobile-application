import 'package:betsbi/manager/SQLLiteManager.dart';
import 'package:betsbi/services/chat/model/newMessage.dart';
import 'package:betsbi/services/global/ISQLLITEManager.dart';
import 'package:sqflite/sqflite.dart';

class SQLLiteNewMessage implements ISQLLITEManager {

  @override
  Future close() async => SQLLiteManager.db.close();

  @override
  Future<int> delete(int id) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return await SQLLiteManager.db.delete('message', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteById(String userIdFrom) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return await SQLLiteManager.db
        .delete('message', where: 'userIdFrom = ?', whereArgs: [userIdFrom]);
  }

  Future<int> countByIdTo(String userIdTo) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return Sqflite.firstIntValue(
      await SQLLiteManager.db
          .rawQuery('SELECT COUNT(*) FROM message WHERE userIdTo = "$userIdTo"'),
    );
  }

  Future<int> countByIdFromAndTo({String userIdFrom, String userIdTo}) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return Sqflite.firstIntValue(
      await SQLLiteManager.db.rawQuery(
          'SELECT COUNT(*) FROM message WHERE userIdTo = "$userIdTo" And userIdFrom = "$userIdFrom"'),
    );
  }

  @override
  Future<List<NewMessage>> getAll() async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    final List<Map<String, dynamic>> maps = await SQLLiteManager.db.query('message');

    return List.generate(maps.length, (i) {
      return NewMessage(
        userIdFrom: maps[i]['userIdFrom'],
        userIdTo: maps[i]['userIdTo'],
      );
    });
  }

  @override
  Future<int> insert(dynamic newMessage) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    newMessage.id = await SQLLiteManager.db.insert('message', newMessage.toMap());
    return newMessage.id;
  }


  @override
  Future<int> update(dynamic message) async {
    return await SQLLiteManager.db.update('message', message.toMap(),
        where: 'id = ?', whereArgs: [message.id]);
  }
}
