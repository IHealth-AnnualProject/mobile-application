import 'dart:io';

import 'package:betsbi/controller/AmbianceController.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> downloadFile({String fileName, String musicId}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$fileName');
    var response = await AmbianceController.downloadFile(musicId: musicId);
    var bytes = response.bodyBytes;
    File finalFile = await file.writeAsBytes(bytes, flush: true);
    return finalFile;
  }

  static Future<bool> checkIfFileExist({String fileName}) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$fileName');
    return await file.exists();
  }
}
