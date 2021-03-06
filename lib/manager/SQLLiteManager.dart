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
        await _db.execute(
          'CREATE TABLE notification(id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' notificationId INTEGER,'
              ' notificationTitle TEXT,'
              ' notificationBody TEXT ,'
              ' notificationType TEXT,'
              ' notificationDate TEXT)',
        );
        await _db.execute(
            'CREATE TABLE quest(id INTEGER PRIMARY KEY AUTOINCREMENT, '
                ' userId TEXT,'
                ' questTitle TEXT,'
                ' questDescription TEXT,'
                ' questDifficulty TEXT,'
                ' questDone INTEGER)'
        );
      },
      version: 1,
    );
  }
}
