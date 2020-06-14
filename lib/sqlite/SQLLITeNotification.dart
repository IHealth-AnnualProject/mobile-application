import 'package:betsbi/model/notification.dart';
import 'package:betsbi/service/SQLLiteManager.dart';

import 'ISQLLITEManager.dart';

class SQLLiteNotification implements ISQLLITEManager {
  @override
  Future close() async => SQLLiteManager.db.close();

  @override
  Future<int> delete(int id) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return await SQLLiteManager.db
        .delete('notification', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteById(int notificationId) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    return await SQLLiteManager.db.delete('notification',
        where: 'notificationId = ?', whereArgs: [notificationId]);
  }
  Future<int> deleteByIdWithType(int notificationId, String notificationType) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    List<LocalNotification> list = List<LocalNotification>();
    list = await getAll();
    LocalNotification localNotificationToDelete = list.firstWhere((element) => element.notificationType == notificationType && element.notificationId == notificationId);
    await SQLLiteManager.db.delete('notification',
        where: 'id = ?', whereArgs: [localNotificationToDelete.id]);
    return localNotificationToDelete.id;
  }

  @override
  Future<List<LocalNotification>> getAll() async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    final List<Map<String, dynamic>> maps =
        await SQLLiteManager.db.query('notification');

    return List.generate(maps.length, (i) {
      return LocalNotification(
        id: maps[i]['id'],
        notificationId: maps[i]['notificationId'],
        notificationType: maps[i]['notificationType'],
        notificationTitle: maps[i]['notificationTitle'],
        notificationBody: maps[i]['notificationBody'],
        notificationDate: maps[i]['notificationDate'],
      );
    });
  }

  @override
  Future<int> insert(dynamic newNotification) async {
    await SQLLiteManager.openDatabaseAndCreateTable();
    newNotification.id =
        await SQLLiteManager.db.insert('notification', newNotification.toMap());
    return newNotification.id;
  }

  @override
  Future<int> update(dynamic notification) async {
    return await SQLLiteManager.db.update('notification', notification.toMap(),
        where: 'id = ?', whereArgs: [notification.id]);
  }
}
