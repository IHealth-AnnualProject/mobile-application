import 'dart:io';

class PubManager{

  String getAppId() {
    if (Platform.isIOS)
      return "ca-app-pub-4901338220117159~8615780719";
    else
      return "ca-app-pub-4901338220117159~3938169107";
  }

  String getBannerAdUnitId()
  {
    if(Platform.isIOS)
      return "ca-app-pub-4901338220117159/8532020232";
    else
      return "ca-app-pub-4901338220117159/9940045640";
  }


}