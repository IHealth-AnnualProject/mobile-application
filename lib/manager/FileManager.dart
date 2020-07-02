import 'dart:io';

import 'package:betsbi/services/relaxing/controller/AmbianceController.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {

  static Future<void> downloadFile({@required String fileName, @required String musicId, @required BuildContext context}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$fileName');
    var response = await AmbianceController.downloadFile(musicId: musicId, context: context);
    var bytes = response.bodyBytes;
    await file.writeAsBytes(bytes, flush: true);
  }

  static Future<bool> checkIfFileExist({@required String fileName}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$fileName');
    return await file.exists();
  }
}
