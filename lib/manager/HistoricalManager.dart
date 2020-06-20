import 'package:flutter/cupertino.dart';

class HistoricalManager {
  static List<Widget> historical = List<Widget>();
  //todo handle logs here

  static addCurrentWidgetToHistorical(Widget currentWidget){
    if(HistoricalManager.historical.isEmpty)
      HistoricalManager.historical.add(currentWidget);
    else if (HistoricalManager.historical.last.toString() != currentWidget.toString())
      HistoricalManager.historical.add(currentWidget);
  }

}
