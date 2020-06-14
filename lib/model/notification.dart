import 'package:flutter/cupertino.dart';

class LocalNotification {
  int id;
  int notificationId;
  String notificationTitle;
  String notificationBody;
  String notificationType;
  String notificationDate;

  LocalNotification(
      {this.id,
      @required this.notificationId,
      @required this.notificationTitle,
      @required this.notificationBody,
      @required this.notificationType,
      @required this.notificationDate,});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'notificationId': notificationId,
      'notificationTitle': notificationTitle,
      'notificationBody': notificationBody,
      'notificationType': notificationType,
      'notificationDate': notificationDate
    };
    if (id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'Notification{id: $id, notification ID: $notificationId,'
        ' notification Title : $notificationTitle,'
        ' notification Body : $notificationBody,'
        ' notification Type: $notificationType,'
        ' notification Date : $notificationDate}';
  }
}
