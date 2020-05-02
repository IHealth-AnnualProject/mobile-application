import 'dart:math';

class QuestController {
  static int generateGainAccordingToState(String state) {
    var random = Random();
    int calculatedExperienceGained = 0;
    switch (state) {
      case "easy":
        calculatedExperienceGained = random.nextInt(26) * 1;
        break;
      case "medium":
        calculatedExperienceGained = random.nextInt(51) * 2;
        break;
      case "hard":
        calculatedExperienceGained = random.nextInt(76) * 3;
        break;
    }
    return calculatedExperienceGained == 0
        ? generateGainAccordingToState(state)
        : calculatedExperienceGained;
  }
}
