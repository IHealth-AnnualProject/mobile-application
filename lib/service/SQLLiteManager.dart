import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLLiteManager {
  static Database db;

  static Future openDatabaseAndCreateTable() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'betsbi_database.db'),
      onCreate: (Database _db, int version) async {
        await _db.execute(
          'CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, dueDate TEXT)',
        );
        await _db.execute(
          'CREATE TABLE message(id INTEGER PRIMARY KEY AUTOINCREMENT, userIdTo TEXT, userIdFrom TEXT)',
        );
      },
      version: 1,
    );
  }
}
