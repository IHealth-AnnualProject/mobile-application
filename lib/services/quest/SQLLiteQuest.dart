import 'package:betsbi/manager/SQLLiteManager.dart';
import 'package:betsbi/services/quest/model/quest.dart';
import 'package:betsbi/services/global/ISQLLITEManager.dart';

class SQLLiteQuest implements ISQLLITEManager {
  @override
  Future<int> insert(dynamic quest) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    quest.questId = await SQLLiteManager.db.insert('quest', quest.toMap());
    return quest.questId;
  }

  @override
  Future<List<Quest>> getAll() async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    final List<Map<String, dynamic>> maps =
        await SQLLiteManager.db.query('quest');
    if (maps.length == 0) return new List<Quest>();
    return List.generate(maps.length, (i) {
      return Quest(
          questId: maps[i]['id'],
          questTitle: maps[i]['questTitle'],
          questDifficulty: maps[i]['questDifficulty'],
          questDescription: maps[i]['questDescription'],
          questDone: maps[i]['questDone']);
    });
  }

  @override
  Future<int> update(dynamic quest) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return await SQLLiteManager.db
        .update('quest', quest.toMap(), where: 'id = ?', whereArgs: [quest.questId]);
  }

  @override
  Future<int> delete(int id) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return await SQLLiteManager.db
        .delete('quest', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async => SQLLiteManager.db.close();
}
