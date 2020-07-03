import 'package:betsbi/manager/SettingsManager.dart';
import 'package:betsbi/services/legal/widget/LegalPart.dart';
import 'package:flutter/cupertino.dart';

class LegalMentionController {

  static List<Widget> generateContentOfLegalPageAccordingToGivenMap(Map<String, dynamic> content) {
    List<Widget> pageElements = new List<Widget>();
    content.forEach(
      (title, content) {
        pageElements.add(
          LegalPart(
            title: SettingsManager.mapLanguage[title],
            content: content,
          ),
        );
      },
    );
    return pageElements;
  }
}
