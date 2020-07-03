import 'package:admob_flutter/admob_flutter.dart';

class HomeController{
  static void printCurrentEventResults(AdmobAdEvent event, Map<String, dynamic> args) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('Admob banner loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob banner opened!');
        break;

      case AdmobAdEvent.closed:
        print('Admob banner closed!');
        break;

      case AdmobAdEvent.failedToLoad:
        print('Admob banner failed to load. Error code: ${args['errorCode']}');
        break;
      case AdmobAdEvent.clicked:
        print('Admob banner clicked!');
        break;
      case AdmobAdEvent.impression:
        print('Admob banner impression!');
        break;
      case AdmobAdEvent.leftApplication:
        print('Admob banner leftApplication!');
        break;
      case AdmobAdEvent.completed:
        print('Admob banner completed!');
        break;
      case AdmobAdEvent.rewarded:
        print('Admob banner rewarded!');
        break;
      case AdmobAdEvent.started:
        print('Admob banner started!');
        break;
    }
  }
}